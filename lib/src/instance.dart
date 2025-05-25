import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;

import 'database/database.dart';
import 'router/render.dart';

class SqliteUI {
  final UIDatabase db;
  final UIRouter router;
  final http.Client Function() createHttpClient;

  SqliteUI(
    this.db, {
    http.Client Function()? createHttpClient,
    bool htmlEscapeValues = false,
  })  : router = UIRouter(
          db,
          createHttpClient: createHttpClient,
          htmlEscapeValues: htmlEscapeValues,
        ),
        createHttpClient = createHttpClient ?? http.Client.new;

  Future<Uint8List> call(String path) async {
    return router.renderRoute(path);
  }

  Future<int> addAsset(String name, Uint8List content, String mimeType) async {
    return db.insertAsset(
      name,
      mimeType,
      content,
      null, // description
    );
  }

  Future<int> addSqlDataLoader(String name, String sqlTemplate) async {
    final dataSourceId =
        await db.insertDataSource(name, 'sql', null /* description */);
    await db.insertSqlSourceConfig(
      dataSourceId,
      sqlTemplate,
    );
    return dataSourceId;
  }

  Future<int> addJsonDataLoader(String name, String assetName) async {
    final asset = await db.getAssetByName(assetName).getSingleOrNull();
    if (asset == null) {
      throw Exception('Asset with name $assetName not found');
    }
    final dataSourceId =
        await db.insertDataSource(name, 'json', null /* description */);
    await db.insertJsonSourceConfig(
      dataSourceId,
      asset.id,
    );
    return dataSourceId;
  }

  Future<int> addHttpDataLoader(String name, String urlTemplate) async {
    final dataSourceId =
        await db.insertDataSource(name, 'http', null /* description */);
    await db.insertHttpSourceConfig(
      dataSourceId,
      urlTemplate,
      'GET', // method
      null, // headersTemplate
      null, // bodyTemplate
    );
    return dataSourceId;
  }

  Future<int> addTemplate(String name, int contentAssetId,
      [String? description]) async {
    return db.insertTemplate(
      name,
      contentAssetId,
      description,
    );
  }

  Future<int> addRoute({
    required String path,
    int? templateId,
    int? assetId,
    String? redirectTo,
    String? description,
  }) async {
    if ((templateId == null && assetId == null) ||
        (templateId != null && assetId != null)) {
      throw ArgumentError(
          'Exactly one of templateId or assetId must be provided.');
    }
    return db.insertRoute(
      path,
      templateId,
      assetId,
      description,
      redirectTo,
    );
  }
}
