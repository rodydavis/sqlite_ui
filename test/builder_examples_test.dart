import 'dart:convert';
import 'package:test/test.dart';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() {
  group('SqliteUIBuilder Examples', () {
    test('json_builder example renders expected HTML', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: initFunctions));
      final builder = SqliteUIBuilder(db);
      final template = builder.addStringTemplate(
        'main_page_template',
        '<h1>{{jsonData.message}}</h1>',
      );
      final dataSource = builder.addJsonDataSource(
        'jsonData',
        {'message': 'Hello from JSON via SqliteUIBuilder!'},
      );
      builder.addRoute(
        '/',
        template: template,
        dataSources: [dataSource],
      );
      await builder.build();
      final router = UIRouter(db);
      final bytes = await router.renderRoute('/');
      final content = utf8.decode(bytes);
      expect(content, contains('Hello from JSON via SqliteUIBuilder!'));
      await db.close();
    });

    test('sql_builder example renders product list and details', () async {
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
      final template = builder.addStringTemplate(
        'products_template',
        '<h1>Product List</h1>\n<ul>{{#products}}<li><strong>{{name}}</strong>: {{description}} - \${{price}}</li>{{/products}}{{^products}}<li>No products found.</li>{{/products}}</ul>',
      );
      final dataSource = builder.addSqlDataSource(
        'products',
        'SELECT id, name, description, price FROM products;',
      );
      builder.addRoute(
        '/products',
        template: template,
        dataSources: [dataSource],
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

    test('http_builder example renders post', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: initFunctions));
      final builder = SqliteUIBuilder(db);
      final template = builder.addStringTemplate(
        'post_template',
        '<h1>Post {{postData.id}}: {{postData.title}}</h1>\n<p>{{postData.body}}</p>',
      );
      final dataSource = builder.addHttpDataSource(
        'postData',
        'https://jsonplaceholder.typicode.com/posts/{{id}}',
        method: 'GET',
      );
      builder.addRoute(
        '/posts/:id',
        template: template,
        dataSources: [dataSource],
      );
      await builder.build();
      final router = UIRouter(db);
      // Only check that the route renders and contains 'Post' (do not depend on live API content)
      final bytes = await router.renderRoute('/posts/1');
      final content = utf8.decode(bytes);
      expect(content, contains('Post'));
      await db.close();
    });
  });
}
