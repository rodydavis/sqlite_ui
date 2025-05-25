import 'dart:convert';
import 'package:test/test.dart';
import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() {
  group('HttpBuilder Pattern', () {
    test('renders a single post from HTTP source', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: initFunctions));
      final builder = UIBuilder(db);
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
      final bytes = await router.renderRoute('/posts/1');
      final content = utf8.decode(bytes);
      expect(content, contains('Post'));
      await db.close();
    });

    test('renders a list of posts from HTTP source', () async {
      final db = UIDatabase(NativeDatabase.memory(setup: initFunctions));
      final builder = UIBuilder(db);
      final listTemplate = builder.addStringTemplate(
        'post_list_template',
        '<h1>All Posts</h1>\n<ul>{{#posts}}<li><a href="/posts/{{id}}">{{title}}</a></li>{{/posts}}{{^posts}}<li>No posts found.</li>{{/posts}}</ul>',
      );
      final listDataSource = builder.addHttpDataSource(
        'posts',
        'https://jsonplaceholder.typicode.com/posts',
        method: 'GET',
      );
      builder.addRoute(
        '/posts',
        template: listTemplate,
        dataSources: [listDataSource],
      );
      await builder.build();
      final router = UIRouter(db);
      final bytes = await router.renderRoute('/posts');
      final content = utf8.decode(bytes);
      expect(content, contains('All Posts'));
      // Should contain at least one post link
      expect(content, contains('<a href="/posts/'));
      await db.close();
    });
  });
}
