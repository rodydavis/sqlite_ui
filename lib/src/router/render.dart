import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_to_regexp/path_to_regexp.dart' as r;

import '../database/database.dart';
import '../templates/render.dart';

sealed class RouteResult {
  final UIRouter router;
  final Map<String, dynamic> params;
  final String path;

  RouteResult(
    this.router,
    this.path,
    this.params,
  );

  @override
  String toString() {
    return 'RouteResult(router: $router, path: $path, params: $params)';
  }
}

class MissingRouteResult extends RouteResult {
  MissingRouteResult(super.router, super.path, super.params);

  @override
  String toString() {
    return 'MissingRouteResult(path: $path, params: $params)';
  }
}

class AssetResult extends RouteResult {
  final Uint8List content;
  final String mimeType;

  AssetResult(
    super.router,
    super.path,
    super.params,
    this.content,
    this.mimeType,
  );

  @override
  String toString() {
    return 'AssetResult(path: $path, params: $params, mimeType: $mimeType)';
  }
}

class TemplateResult extends RouteResult {
  final String content;

  TemplateResult(
    super.router,
    super.path,
    super.params,
    this.content,
  );

  @override
  String toString() {
    return 'TemplateResult(path: $path, params: $params, content: $content)';
  }
}

class RedirectResult extends RouteResult {
  final String redirectTo;

  RedirectResult(
    super.router,
    super.path,
    super.params,
    this.redirectTo,
  );

  @override
  String toString() {
    return 'RedirectResult(path: $path, params: $params, redirectTo: $redirectTo)';
  }
}

class UIRouter {
  final UIDatabase db;
  final http.Client Function() createHttpClient;
  final bool htmlEscapeValues;

  UIRouter(
    this.db, {
    this.htmlEscapeValues = false,
    http.Client Function()? createHttpClient,
  }) : createHttpClient = createHttpClient ?? http.Client.new;

  Future<Uint8List> renderRoute(String path) async {
    RouteResult result = await getRoute(
      path,
    );
    if (result is MissingRouteResult) {
      throw Exception('Route not found for path: $path');
    }
    while (result is RedirectResult) {
      result = await getRoute(result.redirectTo);
    }
    if (result is AssetResult) {
      return result.content;
    }
    if (result is TemplateResult) {
      final str = result.content;
      final bytes = utf8.encode(str);
      return bytes;
    }
    throw Exception('Unknown route result type');
  }

  Future<RouteResult> getRoute(String path) async {
    final route = await db.getRouteByMatchingPath(path).getSingleOrNull();

    if (route == null) {
      return MissingRouteResult(this, path, {});
    }

    final routeResult = r.match(route.path)(path);
    if (routeResult == null) {
      // This should ideally not happen if getRouteByMatchingPath worked
      throw Exception('Route pattern does not match path: $path');
    }

    if (route.redirectTo != null && route.redirectTo!.isNotEmpty) {
      var redirectTo = route.redirectTo!;
      redirectTo = renderTemplate(
        redirectTo,
        values: routeResult.params, // Parameters from the route path
      );
      return RedirectResult(
        this,
        path,
        routeResult.params,
        redirectTo,
      );
    }

    // Check if the route directly serves an asset
    if (route.assetId != null) {
      final asset = await db.getAssetById(route.assetId!).getSingleOrNull();
      if (asset == null) {
        throw Exception('Asset not found for route: $path');
      }
      // Assuming content is text-based for now, might need handling for binary types
      return AssetResult(
        this,
        path,
        routeResult.params,
        asset.content,
        asset.mimeType,
      );
    }

    if (route.templateId == null) {
      throw Exception('Route does not have a template or asset: $path');
    }

    final templateResult =
        await db.getTemplateById(route.templateId!).getSingleOrNull();
    if (templateResult == null) {
      throw Exception('Template not found for route with path: $path');
    }

    final data = <String, dynamic>{};
    final assignments =
        await db.getRouteDataAssignmentsByRouteId(route.id).get();

    for (final assignment in assignments) {
      final dataSource =
          await db.getDataSourceById(assignment.dataSourceId).getSingle();
      Object? loadedData;

      switch (dataSource.type) {
        case 'sql':
          final config = await db
              .getSqlSourceConfigByDataSourceId(dataSource.id)
              .getSingle();
          final sql = renderTemplate(
            config.sqlTemplate,
            values: routeResult.params, // Parameters from the route path
          );
          final queryResult = await db.customSelect(sql).get();
          loadedData = queryResult.map((row) => row.data).toList();
          break;
        case 'json': // Changed from 'json_file' and 'json_inline'
          final config = await db
              .getJsonSourceConfigByDataSourceId(dataSource.id)
              .getSingle();
          final asset = await db.getAssetById(config.assetId).getSingleOrNull();
          if (asset == null) {
            throw Exception(
                'Asset not found for JSON data source: ${dataSource.name}');
          }
          if (asset.mimeType != 'application/json') {
            print(
                'Warning: Asset for JSON source ${dataSource.name} has MIME type ${asset.mimeType}, expected application/json.');
          }
          try {
            final jsonString = String.fromCharCodes(asset.content);
            loadedData = jsonDecode(jsonString);
          } catch (e) {
            throw Exception(
                'Failed to decode JSON from asset ${asset.name} for data source ${dataSource.name}: $e');
          }
          break;
        case 'http': // Ensure this matches the schema value if you changed it (e.g., from 'http_request')
          final config = await db
              .getHttpSourceConfigByDataSourceId(dataSource.id)
              .getSingle();
          final client = createHttpClient();
          try {
            final req = http.Request(
              config.method,
              Uri.parse(renderTemplate(
                config.urlTemplate,
                values: routeResult.params, // Parameters from the route path
              )),
            );
            if (config.headersTemplate != null) {
              final headers = renderTemplate(
                config.headersTemplate!,
                values: routeResult.params, // Parameters from the route path
              );
              req.headers.addAll((jsonDecode(headers) as Map).cast());
            }
            if (config.bodyTemplate != null) {
              final body = renderTemplate(
                config.bodyTemplate!,
                values: routeResult.params, // Parameters from the route path
              );
              req.body = body;
            }
            final res = await client.send(req);
            if (res.statusCode != 200) {
              log(
                'HTTP request failed with status ${res.statusCode} for URL: ${req.url}',
              );
            } else {
              final bytes = await res.stream.toBytes();
              final contentType = res.headers['content-type'] ?? '';
              if (contentType.startsWith('application/json')) {
                loadedData = jsonDecode(utf8.decode(bytes));
              } else if (contentType.startsWith('text/')) {
                loadedData = utf8.decode(bytes);
              } else {
                log(
                  'Unsupported content type "$contentType" for HTTP source ${dataSource.name}. Expected application/json or text/*.',
                );
              }
            }
          } catch (e) {
            log('Failed to fetch data from HTTP source ${dataSource.name}: $e');
          } finally {
            client.close();
          }
        default:
          throw Exception('Unknown data source type: ${dataSource.type}');
      }
      data[assignment.contextName] = loadedData ?? false;
    }

    // Template content is now part of the GetTemplateByIdResult custom result object
    final templateContent = templateResult.templateContent;
    final templateString = String.fromCharCodes(templateContent);

    final str = renderTemplate(
      templateString,
      values: data,
      lenient: true,
      htmlEscapeValues: htmlEscapeValues,
      name: templateResult.name, // from templates table
    );
    return TemplateResult(
      this,
      path,
      routeResult.params,
      str,
    );
  }
}
