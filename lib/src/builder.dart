import 'dart:convert';
import 'dart:typed_data';

import 'database/database.dart' show UIDatabase;

sealed class _Core {
  late int id;
  bool built = false;

  Future<int> build(UIDatabase db);

  Future<int> create(UIDatabase db) async {
    if (built) return id;
    this.id = await build(db);
    built = true;
    return id;
  }
}

class AssetBuilder extends _Core {
  String name;
  String mimeType;
  Uint8List content;

  AssetBuilder({
    required this.name,
    required this.mimeType,
    required this.content,
  });

  factory AssetBuilder.fromJson(String name, Map<String, dynamic> json) {
    return AssetBuilder(
      name: name,
      mimeType: 'application/json',
      content: Uint8List.fromList(jsonEncode(json).codeUnits),
    );
  }

  factory AssetBuilder.fromString(
    String name,
    String content, {
    String mimeType = 'text/plain',
  }) {
    return AssetBuilder(
      name: name,
      mimeType: mimeType,
      content: Uint8List.fromList(content.codeUnits),
    );
  }

  @override
  Future<int> build(UIDatabase db) async {
    return await db.insertAsset(
      name,
      mimeType,
      content,
      null, // description
    );
  }
}

class TemplateBuilder extends _Core {
  String name;
  AssetBuilder asset;

  TemplateBuilder({
    required this.name,
    required this.asset,
  });

  factory TemplateBuilder.fromString(String name, String content) {
    return TemplateBuilder(
      name: name,
      asset: AssetBuilder.fromString(name, content),
    );
  }

  @override
  Future<int> build(UIDatabase db) async {
    return await db.insertTemplate(
      name,
      await asset.create(db),
      null, // description
    );
  }
}

class DataSourceBuilder extends _Core {
  String name;
  String type;

  Future<int> Function(UIDatabase db, int dataSourceId)? config;

  DataSourceBuilder({
    required this.name,
    required this.type,
  });

  factory DataSourceBuilder.sql(
    String name,
    String sqlTemplate,
  ) {
    final source = DataSourceBuilder(
      name: name,
      type: 'sql',
    );
    source.config = (db, id) async {
      return await db.insertSqlSourceConfig(
        id,
        sqlTemplate,
      );
    };
    return source;
  }

  factory DataSourceBuilder.json(
    String name,
    Map<String, dynamic> json,
  ) {
    final source = DataSourceBuilder(
      name: name,
      type: 'json',
    );
    source.config = (db, id) async {
      final assetName = '${name}_${id}_json';
      final asset = AssetBuilder.fromJson(assetName, json);
      return await db.insertJsonSourceConfig(
        id,
        await asset.create(db),
      );
    };
    return source;
  }

  factory DataSourceBuilder.http(
    String name,
    String urlTemplate, {
    String method = 'GET',
    String? headersTemplate,
    String? bodyTemplate,
  }) {
    final source = DataSourceBuilder(
      name: name,
      type: 'http',
    );
    source.config = (db, id) async {
      return await db.insertHttpSourceConfig(
        id,
        urlTemplate,
        method,
        headersTemplate,
        bodyTemplate,
      );
    };
    return source;
  }

  @override
  Future<int> build(UIDatabase db) async {
    final id = await db.insertDataSource(
      name,
      type,
      null, // description
    );
    if (config != null) await config!(db, id);
    return id;
  }
}

class RouteBuilder extends _Core {
  String path;
  TemplateBuilder? template;
  AssetBuilder? asset;
  List<DataSourceBuilder> dataSources;
  String? redirectTo; // New: redirect target

  RouteBuilder({
    required this.path,
    this.template,
    this.asset,
    this.dataSources = const [],
    this.redirectTo,
  });

  factory RouteBuilder.fromTemplate(
    String path,
    TemplateBuilder template,
  ) {
    return RouteBuilder(
      path: path,
      template: template,
    );
  }

  factory RouteBuilder.fromAsset(
    String path,
    AssetBuilder asset,
  ) {
    return RouteBuilder(
      path: path,
      asset: asset,
    );
  }

  factory RouteBuilder.redirect(String path, String redirectTo) {
    return RouteBuilder(
      path: path,
      redirectTo: redirectTo,
    );
  }

  @override
  Future<int> build(UIDatabase db) async {
    final id = await db.insertRoute(
      path,
      await template?.create(db),
      await asset?.create(db),
      null, // description
      redirectTo, // Pass redirect target if supported by insertRoute
    );
    for (final dataSource in dataSources) {
      final dataSourceId = await dataSource.create(db);
      await db.insertRouteDataAssignment(
        id,
        dataSourceId,
        dataSource.name, // contextName
        0, // executionOrder
      );
    }
    return id;
  }
}

class SqliteUIBuilder {
  final UIDatabase db;

  SqliteUIBuilder(this.db);

  List<AssetBuilder> assets = [];
  List<TemplateBuilder> templates = [];
  List<RouteBuilder> routes = [];
  List<DataSourceBuilder> dataSources = [];

  Future<void> build() async {
    for (final asset in assets) {
      await asset.create(db);
    }
    for (final template in templates) {
      await template.create(db);
    }
    for (final dataSource in dataSources) {
      await dataSource.create(db);
    }
    for (final route in routes) {
      await route.create(db);
    }
  }

  AssetBuilder addAsset(
    String name,
    String mimeType,
    Uint8List content,
  ) {
    final asset = AssetBuilder(
      name: name,
      mimeType: mimeType,
      content: content,
    );
    assets.add(asset);
    return asset;
  }

  TemplateBuilder addTemplate(
    String name,
    AssetBuilder asset,
  ) {
    final template = TemplateBuilder(
      name: name,
      asset: asset,
    );
    templates.add(template);
    return template;
  }

  TemplateBuilder addStringTemplate(
    String name,
    String content,
  ) {
    final template = TemplateBuilder.fromString(name, content);
    templates.add(template);
    return template;
  }

  DataSourceBuilder addJsonDataSource(
    String name,
    Map<String, dynamic> json,
  ) {
    final dataSource = DataSourceBuilder.json(name, json);
    dataSources.add(dataSource);
    return dataSource;
  }

  DataSourceBuilder addSqlDataSource(
    String name,
    String sqlTemplate,
  ) {
    final dataSource = DataSourceBuilder.sql(name, sqlTemplate);
    dataSources.add(dataSource);
    return dataSource;
  }

  DataSourceBuilder addHttpDataSource(
    String name,
    String urlTemplate, {
    String method = 'GET',
    String? headersTemplate,
    String? bodyTemplate,
  }) {
    final dataSource = DataSourceBuilder.http(
      name,
      urlTemplate,
      method: method,
      headersTemplate: headersTemplate,
      bodyTemplate: bodyTemplate,
    );
    dataSources.add(dataSource);
    return dataSource;
  }

  RouteBuilder addRoute(
    String path, {
    TemplateBuilder? template,
    AssetBuilder? asset,
    List<DataSourceBuilder>? dataSources,
    String? redirectTo, // New
  }) {
    final route = RouteBuilder(
      path: path,
      template: template,
      asset: asset,
      dataSources: dataSources ?? [],
      redirectTo: redirectTo,
    );
    routes.add(route);
    return route;
  }

  RouteBuilder addRedirect(String path, String redirectTo) {
    final route = RouteBuilder.redirect(path, redirectTo);
    routes.add(route);
    return route;
  }

  AssetBuilder addStringAsset(
    String name,
    String content, {
    String mimeType = 'text/plain',
  }) {
    final asset = AssetBuilder.fromString(
      name,
      content,
      mimeType: mimeType,
    );
    assets.add(asset);
    return asset;
  }
}
