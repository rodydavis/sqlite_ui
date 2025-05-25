# SQLite UI - Dynamic UI Rendering with SQLite & Mustache

**sqlite_ui** is a Dart package that allows you to build dynamic user interfaces by defining routes, templates (using Mustache), and data sources (SQL, JSON, HTTP) within an SQLite database. It provides a flexible way to manage and render UI components, especially for applications where UI structure and content can change frequently or are driven by external data.

This package is ideal for scenarios where you want to:

*   Define UI routes and their corresponding templates in a database.
*   Fetch data for these templates from various sources like direct SQL queries against the main or attached SQLite databases, local JSON assets, or remote HTTP endpoints.
*   Render HTML (or other text-based formats) using Mustache templates populated with the fetched data.
*   Serve static assets directly from the database.

## Features

*   **Database-Driven Routes**: Define URL paths and associate them with templates or static assets stored in SQLite.
*   **Mustache Templates**: Use Mustache for templating, with content also stored in SQLite (as assets).
*   **Flexible Data Sources**:
    *   **SQL**: Execute SQL queries against the main SQLite database or attached databases. Route parameters can be used in your SQL queries.
    *   **JSON**: Load data from JSON files stored as assets within the SQLite database.
    *   **HTTP**: Fetch data from external HTTP/S endpoints. Route parameters can be used in URLs, headers, and bodies.
*   **Static Asset Serving**: Store and serve static files (CSS, JS, images as BLOBs) directly from the SQLite database.
*   **Path-to-RegExp Routing**: Supports Express-style route matching with parameters (e.g., `/users/:id`).

## Installation

1.  Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  sqlite_ui:
    git:
      url: https://github.com/rodydavis/sqlite_ui
```

2.  Install it:

```bash
dart pub get
```

## Basic Usage

Here's a conceptual overview of how to set up and use `sqlite_ui`.

### 1. Create the Database and Define Routes

```dart
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initFunctions, // Register custom SQLite functions if needed
  ));
  final builder = SqliteUIBuilder(db);

  // Add a Mustache template using the builder
  final template = builder.addStringTemplate(
    'greet_template',
    '<h1>Hello {{person.name}}!</h1><p>Your lucky number is {{data.lucky_number}}.</p>',
  );

  // Add a SQL data source using the builder
  final dataSource = builder.addSqlDataSource(
    'data',
    "SELECT 7 AS lucky_number, '{{name}}' as person_name;",
  );

  // Add a route using the builder
  builder.addRoute(
    '/hello/:name',
    template: template,
    dataSources: [dataSource],
  );

  // Build all entities
  await builder.build();
  final router = UIRouter(db);

  // --- Render a Route ---
  final String pathToRender = '/hello/World';
  print("Rendering route: $pathToRender");
  try {
    final List<int> renderedBytes = await router.renderRoute(pathToRender, htmlEscapeValues: false);
    final String renderedContent = utf8.decode(renderedBytes);
    print("Rendered Output:\n$renderedContent");
    // Expected: <h1>Hello World!</h1><p>Your lucky number is 7.</p>
  } catch (e, s) {
    print("Error rendering route: $e");
    print(s);
  }

  await db.close();
}
```

### 2. Render a Route

```dart
import 'dart:convert';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initFunctions, // Register custom SQLite functions if needed
  ));
  final router = UIRouter(db);
  final String pathToRender = '/hello/World';
  print("Rendering route: $pathToRender");
  try {
    final renderedBytes = await router.renderRoute(pathToRender);
    final renderedContent = utf8.decode(renderedBytes);
    print("Rendered Output:\n$renderedContent");
    // Expected: <h1>Hello World!</h1><p>Your lucky number is 7.</p>
  } catch (e, s) {
    print("Error rendering route: $e");
    print(s);
  }
  await db.close();
}
```

## Examples

For more detailed examples, please see the `example/` directory in this repository. It includes demonstrations of:

*   Basic JSON data loading (`json.dart`)
*   HTTP data fetching (`http.dart`)
*   Querying an attached SQLite database (`sql.dart`)
*   Routing with path arguments (`routing.dart`)
