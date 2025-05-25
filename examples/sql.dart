import 'dart:convert';

import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: (database) {
      initUIFunctions(database);
      // Create a products table and insert sample data
      database.execute('''
        CREATE TABLE products (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          description TEXT,
          price REAL
        );
      ''');
      database.execute('''
        INSERT INTO products (name, description, price) VALUES
          ('Widget', 'A useful widget', 19.99),
          ('Gadget', 'A fancy gadget', 29.99),
          ('Thingamajig', 'A mysterious thingamajig', 9.99);
      ''');
    },
  ));
  final builder = UIBuilder(db);

  // Add a Mustache template for displaying products
  final template = builder.addStringTemplate(
    'products_template',
    r'''
    <h1>Product List</h1>
    <ul>
      {{#products}}
        <li>
          <strong>{{name}}</strong>: {{description}} - ${{price}}
        </li>
      {{/products}}
      {{^products}}
        <li>No products found.</li>
      {{/products}}
    </ul>
    '''
        .trim(),
  );
  print('Added template: ${template.name}');

  // Add a SQL data source for products
  final dataSource = builder.addSqlDataSource(
    'products',
    'SELECT id, name, description, price FROM products;',
  );
  print('Added data source: ${dataSource.name}');

  // Add a route for path "/products"
  final route = builder.addRoute(
    '/products',
    template: template,
    dataSources: [dataSource],
  );
  print('Added route: ${route.path}');

  // Add a Mustache template for displaying product details
  final detailTemplate = builder.addStringTemplate(
    'product_detail_template',
    r'''
    {{#product}}
      <h1>{{name}}</h1>
      <p><strong>Description:</strong> {{description}}</p>
      <p><strong>Price:</strong> ${{price}}</p>
    {{/product}}
    {{^product}}
      <h1>Product Not Found</h1>
      <p>The product you are looking for does not exist.</p>
    {{/product}}
    <p><a href="/products">Back to product list</a></p>
    '''
        .trim(),
  );
  print('Added detail template: ${detailTemplate.name}');

  // Add a SQL data source for product details by ID
  final detailDataSource = builder.addSqlDataSource(
    'product',
    'SELECT id, name, description, price FROM products WHERE id = {{productId}};',
  );
  print('Added detail data source: ${detailDataSource.name}');

  // Add a route for path "/products/:productId"
  final detailRoute = builder.addRoute(
    '/products/:productId',
    template: detailTemplate,
    dataSources: [detailDataSource],
  );
  print('Added detail route: ${detailRoute.path}');

  // Build all entities
  await builder.build();
  print('SqliteUIBuilder build complete.');

  // Render the route
  final router = UIRouter(db);
  print('Rendering route "/products":');
  try {
    final bytes = await router.renderRoute('/products');
    final content = utf8.decode(bytes);
    print('Rendered content: $content');
  } catch (e) {
    print('Error rendering route: $e');
  }

  // Render a detail route as an example (for product with ID 1)
  print('Rendering detail route "/products/1":');
  try {
    final bytes = await router.renderRoute('/products/1');
    final content = utf8.decode(bytes);
    print('Rendered detail content: $content');
  } catch (e) {
    print('Error rendering detail route: $e');
  }

  await db.close();
}
