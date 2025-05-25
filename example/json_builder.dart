import 'dart:convert';

import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initFunctions,
  ));
  final builder = SqliteUIBuilder(db);

  // Add the template, using the asset created above
  final template = builder.addStringTemplate(
    'main_page_template',
    // Define Mustache template content that uses "jsonData"
    '<h1>{{jsonData.message}}</h1>',
  );
  print('Added template: ${template.name}');

  // Add a JSON data source named "jsonData"
  // The builder's addJsonDataSource takes a Map<String, dynamic>.
  // The name given here ("jsonData") will be used as the contextName in the template.
  final dataSource = builder.addJsonDataSource(
    'jsonData', // This name will be the contextName for the template
    // Define JSON content
    {"message": "Hello from JSON via SqliteUIBuilder!"},
  );
  print('Added data source: ${dataSource.name}');

  // Add a route for path "/"
  // Assign the template and the data source to this route.
  // The SqliteUIBuilder will automatically create a RouteDataAssignment
  // using dataSource.name (which is "jsonData") as the contextName.
  final route = builder.addRoute(
    '/',
    template: template,
    dataSources: [dataSource], // Pass the dataSource here
  );
  print('Added route: ${route.path}');

  // Build all entities
  // This will create all assets, templates, data sources, routes, and their assignments.
  await builder.build();
  print('SqliteUIBuilder build complete.');

  // Render the route
  final router = UIRouter(db);
  print('Rendering route "/":');
  try {
    final bytes = await router.renderRoute('/');
    final content = utf8.decode(bytes);
    print('Rendered content: $content');
    // Expected output: Rendered content: <h1>Hello from JSON via SqliteUIBuilder!</h1>
  } catch (e) {
    print('Error rendering route: $e');
  }

  await db.close();
}
