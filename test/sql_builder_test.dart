import 'dart:convert';
import 'package:test/test.dart';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() {
  group('SqlBuilder Pattern', () {
    test('renders product list and details using builder', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: (database) {
        initFunctions(database);
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
      }));
      final builder = SqliteUIBuilder(db);
      final listTemplate = builder.addStringTemplate(
        'products_template',
        '<h1>Product List</h1>\n<ul>{{#products}}<li><strong>{{name}}</strong>: {{description}} - \${{price}}</li>{{/products}}{{^products}}<li>No products found.</li>{{/products}}</ul>',
      );
      final listDataSource = builder.addSqlDataSource(
        'products',
        'SELECT id, name, description, price FROM products;',
      );
      builder.addRoute(
        '/products',
        template: listTemplate,
        dataSources: [listDataSource],
      );
      final detailTemplate = builder.addStringTemplate(
        'product_detail_template',
        '{{#product}}<h1>{{name}}</h1><p><strong>Description:</strong> {{description}}</p><p><strong>Price:</strong> \${{price}}</p>{{/product}}{{^product}}<h1>Product Not Found</h1><p>The product you are looking for does not exist.</p>{{/product}}<p><a href="/products">Back to product list</a></p>',
      );
      final detailDataSource = builder.addSqlDataSource(
        'product',
        'SELECT id, name, description, price FROM products WHERE id = {{productId}};',
      );
      builder.addRoute(
        '/products/:productId',
        template: detailTemplate,
        dataSources: [detailDataSource],
      );
      await builder.build();
      final router = UIRouter(db);
      final listBytes = await router.renderRoute('/products');
      final listContent = utf8.decode(listBytes);
      expect(listContent, contains('Widget'));
      expect(listContent, contains('Gadget'));
      expect(listContent, contains('Thingamajig'));
      final detailBytes = await router.renderRoute('/products/1');
      final detailContent = utf8.decode(detailBytes);
      expect(detailContent, contains('Widget'));
      expect(detailContent, contains('A useful widget'));
      await db.close();
    });
  });
}
