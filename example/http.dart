import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initFunctions,
  ));
  final router = UIRouter(db);

  // 1. Add a Mustache template for displaying a post
  final templateString = '''
  <h1>Post {{postData.id}}: {{postData.title}}</h1>
  <p>{{postData.body}}</p>
  ''';
  final templateAssetId = await db.into(db.assets).insert(
        AssetsCompanion.insert(
          name: 'post_template.mustache',
          content: Uint8List.fromList(utf8.encode(templateString)),
          mimeType: 'text/mustache',
        ),
      );
  final actualTemplateId = await db.into(db.templates).insert(
        TemplatesCompanion.insert(
          name: 'post_display_template',
          assetId: templateAssetId,
        ),
      );
  print(
      'Added HTTP template with ID: $actualTemplateId, backed by asset ID: $templateAssetId');

  // 2. Create an 'http' type data source for fetching a single post
  final httpDataSourceId = await db.into(db.dataSources).insert(
        DataSourcesCompanion.insert(
          name: 'jsonPlaceholderPostSource',
          type: 'http',
          description: Value('Fetches a single post from JSONPlaceholder'),
        ),
      );
  print('Added HTTP data source with ID: $httpDataSourceId');

  // 3. Configure the HTTP data source
  await db.into(db.httpSourceConfigs).insert(
        HttpSourceConfigsCompanion.insert(
          dataSourceId: httpDataSourceId,
          urlTemplate: 'https://jsonplaceholder.typicode.com/posts/{{id}}',
          method: Value('GET'),
        ),
      );
  print(
      'Configured HTTP source to fetch from https://jsonplaceholder.typicode.com/posts/{{id}}');

  // 4. Add a route for path "/posts/:id"
  final routeId = await db.into(db.routes).insert(
        RoutesCompanion.insert(
          path: '/posts/:id',
          templateId: Value(actualTemplateId),
          description: Value('Displays a single post by its ID'),
        ),
      );
  print('Added route "/posts/:id" with ID: $routeId');

  // 5. Assign the HTTP data source to the route
  await db.into(db.routeDataAssignments).insert(
        RouteDataAssignmentsCompanion.insert(
          routeId: routeId,
          dataSourceId: httpDataSourceId,
          contextName: 'postData',
          executionOrder: Value(0),
        ),
      );
  print(
      'Assigned data source $httpDataSourceId to route $routeId with context name "postData"');

  // 6. Render the route for a specific post, e.g., /posts/1
  final String testPath = '/posts/1';
  print('Rendering route "$testPath":');
  try {
    final List<int> renderedBytes = await router.renderRoute(testPath);
    final String renderedContent = utf8.decode(renderedBytes);
    print('Rendered content for $testPath:');
    print(renderedContent);
  } catch (e, s) {
    print('Error rendering route $testPath: $e');
    print('Stack trace: $s');
  }

  final String testPath2 = '/posts/2';
  print('Rendering route "$testPath2":');
  try {
    final List<int> renderedBytes2 = await router.renderRoute(testPath2);
    final String renderedContent2 = utf8.decode(renderedBytes2);
    print('Rendered content for $testPath2:');
    print(renderedContent2);
  } catch (e, s) {
    print('Error rendering route $testPath2: $e');
    print('Stack trace: $s');
  }

  await db.close();
}
