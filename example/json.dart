import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initFunctions,
  ));
  final router = UIRouter(db);

  // 1. Add JSON content as an asset
  final jsonContent = '{"message": "Hello from JSON via SQLite UI!"}';
  final jsonAssetId = await db.into(db.assets).insert(
        AssetsCompanion.insert(
          name: 'welcome.json',
          content: Uint8List.fromList(utf8.encode(jsonContent)),
          mimeType: 'application/json',
        ),
      );
  print('Added JSON asset with ID: $jsonAssetId');

  // 2. Add a Mustache template by first creating an asset for its content
  final templateContent = '<h1>{{jsonData.message}}</h1>';
  final templateAssetId = await db.into(db.assets).insert(
        AssetsCompanion.insert(
          name: 'main_page.mustache',
          content: Uint8List.fromList(utf8.encode(templateContent)),
          mimeType: 'text/mustache', // Or text/html, depending on preference
        ),
      );
  final actualTemplateId = await db.into(db.templates).insert(
        TemplatesCompanion.insert(
          name: 'main_page_template',
          assetId: templateAssetId,
        ),
      );
  print(
      'Added template with ID: $actualTemplateId, backed by asset ID: $templateAssetId');

  // 3. Create a 'json' type data source
  final dataSourceId = await db.into(db.dataSources).insert(
        DataSourcesCompanion.insert(
          name: 'welcomeJsonSource',
          type: 'json',
        ),
      );
  print('Added data source with ID: $dataSourceId');

  // 4. Configure the JSON data source to point to the JSON asset
  await db.into(db.jsonSourceConfigs).insert(
        JsonSourceConfigsCompanion.insert(
          dataSourceId: dataSourceId,
          assetId: jsonAssetId, // The asset containing the JSON data
        ),
      );
  print('Configured JSON source to use asset ID: $jsonAssetId');

  // 5. Add a route for path "/"
  final routeId = await db.into(db.routes).insert(
        RoutesCompanion.insert(
          path: '/',
          templateId: Value(actualTemplateId), // Route uses the template
        ),
      );
  print('Added route "/" with ID: $routeId');

  // 6. Assign the data source to the route
  await db.into(db.routeDataAssignments).insert(
        RouteDataAssignmentsCompanion.insert(
          routeId: routeId,
          dataSourceId: dataSourceId,
          contextName:
              'jsonData', // This is how it will be available in the template
          executionOrder: Value(0),
        ),
      );
  print(
      'Assigned data source $dataSourceId to route $routeId with context name "jsonData"');

  // 7. Render the route
  print('Rendering route "/":');
  try {
    final bytes = await router.renderRoute('/');
    final content = utf8.decode(bytes);
    print('Rendered content: $content');
  } catch (e) {
    print('Error rendering route: $e');
  }

  await db.close();
}
