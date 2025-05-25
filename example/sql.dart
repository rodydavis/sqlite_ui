import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

// Assuming initFunctions is defined elsewhere, e.g., in your main lib or another example
// If not, you might need to define it or remove it from NativeDatabase.memory setup.
// For this example, we'll assume it might exist for consistency with other examples.
// void initFunctions(sqlite3.Database db) { /* ... define custom functions ... */ }

void main(List<String> args) async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initFunctions, // Remove if initFunctions is not available/needed
  ));
  final router = UIRouter(db);

  const testDbFile = './test.sqlite3';
  if (args.contains('--create')) {
    // --- Create and populate an external SQLite database ---
    final externalDb = sqlite3.open(testDbFile);
    externalDb.execute('''
    CREATE TABLE external_users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT
    );
  ''');
    externalDb.execute(
        'INSERT INTO external_users (name, email) VALUES (?, ?), (?, ?);', [
      'Alice External',
      'alice@example.com',
      'Bob External',
      'bob@example.com',
    ]);
    print('External SQLite database created and populated in memory.');
  }

  // --- Attach the external database to the main UIDatabase connection ---
  try {
    await db.customStatement('ATTACH DATABASE ? AS external_db;', [testDbFile]);
    print('Successfully attached external database as \'external_db\'.');
  } catch (e) {
    print('Error attaching database: $e');
    await db.close();
    return;
  }

  // 1. Add a Mustache template for displaying external users
  final templateString = '''
  <h2>External Users (from attached DB)</h2>
  <ul>
    {{#users}}
    <li>ID: {{id}}, Name: {{name}}, Email: {{email}}</li>
    {{/users}}
    {{^users}}
    <li>No external users found.</li>
    {{/users}}
  </ul>
  ''';
  final templateAssetId = await db.into(db.assets).insert(
        AssetsCompanion.insert(
          name: 'external_users_template.mustache',
          content: Uint8List.fromList(utf8.encode(templateString)),
          mimeType: 'text/mustache',
        ),
      );
  final actualTemplateId = await db.into(db.templates).insert(
        TemplatesCompanion.insert(
          name: 'external_users_display_template',
          assetId: templateAssetId,
        ),
      );
  print('Added template for external users with ID: $actualTemplateId');

  // 2. Create an 'sql' type data source for querying the attached database
  final sqlDataSourceId = await db.into(db.dataSources).insert(
        DataSourcesCompanion.insert(
          name: 'attachedExternalUsersSource',
          type: 'sql',
          description: Value('Fetches users from the attached external_db'),
        ),
      );
  print('Added SQL data source for attached DB with ID: $sqlDataSourceId');

  // 3. Configure the SQL data source
  await db.into(db.sqlSourceConfigs).insert(
        SqlSourceConfigsCompanion.insert(
          dataSourceId: sqlDataSourceId,
          sqlTemplate:
              'SELECT id, name, email FROM external_db.external_users;', // Query the attached DB
        ),
      );
  print('Configured SQL source to query external_db.external_users');

  // 4. Add a route for path "/external-users"
  final routeId = await db.into(db.routes).insert(
        RoutesCompanion.insert(
          path: '/external-users',
          templateId: Value(actualTemplateId),
          description: Value('Displays users from an attached SQLite database'),
        ),
      );
  print('Added route "/external-users" with ID: $routeId');

  // 5. Assign the SQL data source to the route
  await db.into(db.routeDataAssignments).insert(
        RouteDataAssignmentsCompanion.insert(
          routeId: routeId,
          dataSourceId: sqlDataSourceId,
          contextName:
              'users', // Data will be available as 'users' in the template
          executionOrder: Value(0),
        ),
      );
  print(
      'Assigned data source $sqlDataSourceId to route $routeId with context name "users"');

  // 6. Render the route
  final String testPath = '/external-users';
  print('\nRendering route "$testPath":');
  try {
    final List<int> renderedBytes = await router.renderRoute(testPath);
    final String renderedContent = utf8.decode(renderedBytes);
    print('Rendered content for $testPath:');
    print(renderedContent);
  } catch (e, s) {
    print('Error rendering route $testPath: $e');
    print('Stack trace: $s');
  }

  // --- Cleanup ---
  // Detach database (optional, as closing the main connection usually handles this)
  try {
    await db.customStatement('DETACH DATABASE external_db;');
    print('Detached external_db.');
  } catch (e) {
    print('Error detaching database: $e');
  }

  await db.close();
  print('Example finished.');
}
