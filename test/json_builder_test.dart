import 'dart:convert';
import 'package:test/test.dart';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() {
  group('JsonBuilder Pattern', () {
    test('renders simple JSON asset with builder', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: initFunctions));
      final builder = UIBuilder(db);
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

    test('renders with custom context name', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: initFunctions));
      final builder = UIBuilder(db);
      final template = builder.addStringTemplate(
        'main_page_template',
        '<h1>{{custom.message}}</h1>',
      );
      final dataSource = builder.addJsonDataSource(
        'custom',
        {'message': 'Custom context!'},
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
      expect(content, contains('Custom context!'));
      await db.close();
    });

    test('renders multiple JSON data sources', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: initFunctions));
      final builder = UIBuilder(db);
      final template = builder.addStringTemplate(
        'multi_template',
        '<h1>{{a.message}}</h1><h2>{{b.value}}</h2>',
      );
      final dsA = builder.addJsonDataSource('a', {'message': 'A'});
      final dsB = builder.addJsonDataSource('b', {'value': 42});
      builder.addRoute(
        '/',
        template: template,
        dataSources: [dsA, dsB],
      );
      await builder.build();
      final router = UIRouter(db);
      final bytes = await router.renderRoute('/');
      final content = utf8.decode(bytes);
      expect(content, contains('A'));
      expect(content, contains('42'));
      await db.close();
    });
  });
}
