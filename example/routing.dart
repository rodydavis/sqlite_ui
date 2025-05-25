import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main(List<String> args) async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initFunctions,
  ));
  final router = UIRouter(db);

  if (args.contains('--create')) {
    // --- Setup Local Product Data ---
    await db.customStatement('''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      price REAL NOT NULL,
      description TEXT
    );
  ''');
    await db.customStatement(
      "INSERT INTO products (name, price, description) VALUES (?, ?, ?), (?, ?, ?), (?, ?, ?);",
      [
        'Awesome Gadget',
        19.99,
        'A truly awesome gadget for your daily needs.',
        'Super Widget',
        29.50,
        'The best widget in the market, period.',
        'Mega Gizmo',
        45.00,
        'Power up your life with this mega gizmo.'
      ],
    );
    print('Products table created and populated.');
  }

  // --- Define Templates ---

  // Template for listing all products
  final productListTemplateString = '''
  <h1>All Products</h1>
  <ul>
    {{#all_products_data}}
    <li><a href="/products/{{id}}">{{name}}</a> - \${{price}}</li>
    {{/all_products_data}}
    {{^all_products_data}}
    <li>No products found.</li>
    {{/all_products_data}}
  </ul>
  ''';
  final productListTemplateAssetId = await db.into(db.assets).insert(
        AssetsCompanion.insert(
          name: 'product_list_template.mustache',
          content: Uint8List.fromList(utf8.encode(productListTemplateString)),
          mimeType: 'text/mustache',
        ),
      );
  final productListTemplateDbId = await db.into(db.templates).insert(
        TemplatesCompanion.insert(
          name: 'product_list_page',
          assetId: productListTemplateAssetId,
        ),
      );
  print('Product list template created with ID: $productListTemplateDbId');

  // Template for a single product's details
  final productDetailTemplateString = '''
  {{#product_detail_data}}
    <h1>{{name}}</h1>
    <p><strong>Price:</strong> \${{price}}</p>
    <p><strong>Description:</strong> {{description}}</p>
  {{/product_detail_data}}
  {{^product_detail_data}}
    <h1>Product Not Found</h1>
    <p>The product you are looking for does not exist.</p>
  {{/product_detail_data}}
  <p><a href="/products">Back to product list</a></p>
  ''';
  final productDetailTemplateAssetId = await db.into(db.assets).insert(
        AssetsCompanion.insert(
          name: 'product_detail_template.mustache',
          content: Uint8List.fromList(utf8.encode(productDetailTemplateString)),
          mimeType: 'text/mustache',
        ),
      );
  final productDetailTemplateDbId = await db.into(db.templates).insert(
        TemplatesCompanion.insert(
          name: 'product_detail_page',
          assetId: productDetailTemplateAssetId,
        ),
      );
  print('Product detail template created with ID: $productDetailTemplateDbId');

  // --- Define Data Sources ---

  // Data source for fetching all products
  final allProductsDataSourceId = await db.into(db.dataSources).insert(
        DataSourcesCompanion.insert(
          name: 'allProductsSource',
          type: 'sql',
        ),
      );
  await db.into(db.sqlSourceConfigs).insert(
        SqlSourceConfigsCompanion.insert(
          dataSourceId: allProductsDataSourceId,
          sqlTemplate: 'SELECT id, name, price FROM products;',
        ),
      );
  print(
      'All products SQL data source created with ID: $allProductsDataSourceId');

  // Data source for fetching a single product by ID (parameterized)
  final productByIdDataSourceId = await db.into(db.dataSources).insert(
        DataSourcesCompanion.insert(
          name: 'productByIdSource',
          type: 'sql',
        ),
      );
  await db.into(db.sqlSourceConfigs).insert(
        SqlSourceConfigsCompanion.insert(
          dataSourceId: productByIdDataSourceId,
          // '{{productId}}' will be replaced by the route parameter
          sqlTemplate:
              'SELECT id, name, price, description FROM products WHERE id = {{productId}};',
        ),
      );
  print(
      'Product by ID SQL data source created with ID: $productByIdDataSourceId');

  // --- Define Routes ---

  // Route for listing all products
  final productListRouteId = await db.into(db.routes).insert(
        RoutesCompanion.insert(
          path: '/products',
          templateId: Value(productListTemplateDbId),
        ),
      );
  await db.into(db.routeDataAssignments).insert(
        RouteDataAssignmentsCompanion.insert(
          routeId: productListRouteId,
          dataSourceId: allProductsDataSourceId,
          contextName: 'all_products_data',
          executionOrder: Value(0),
        ),
      );
  print('Route "/products" created with ID: $productListRouteId');

  // Route for displaying a single product
  final productDetailRouteId = await db.into(db.routes).insert(
        RoutesCompanion.insert(
          path: '/products/:productId', // ':productId' is a dynamic segment
          templateId: Value(productDetailTemplateDbId),
        ),
      );
  await db.into(db.routeDataAssignments).insert(
        RouteDataAssignmentsCompanion.insert(
          routeId: productDetailRouteId,
          dataSourceId: productByIdDataSourceId,
          contextName:
              'product_detail_data', // SQL result will be a list, template expects one item or empty
          executionOrder: Value(0),
        ),
      );
  print('Route "/products/:productId" created with ID: $productDetailRouteId');

  // --- Render Routes ---
  Future<void> renderAndPrint(String routePath, String description) async {
    print('--- Rendering $description ($routePath) ---');
    try {
      final List<int> renderedBytes = await router.renderRoute(routePath);
      final String renderedContent = utf8.decode(renderedBytes);
      print(renderedContent);
    } catch (e, s) {
      print('Error rendering route $routePath: $e');
      print('Stack trace: $s');
    }
  }

  await renderAndPrint('/products', 'Product List Page');
  await renderAndPrint('/products/1', 'Product Detail Page (ID: 1)');
  await renderAndPrint('/products/2', 'Product Detail Page (ID: 2)');
  await renderAndPrint(
      '/products/99', 'Product Detail Page (ID: 99 - Not Found)');

  await db.close();
  print('Example finished.');
}
