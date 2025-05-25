import 'dart:convert';

import 'package:drift/native.dart';
import 'package:sqlite_ui/sqlite_ui.dart';

void main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initUIFunctions,
  ));
  final builder = UIBuilder(db);

  // Add a Mustache template for displaying a post
  final template = builder.addStringTemplate(
    'post_template',
    '''
    <h1>Post {{postData.id}}: {{postData.title}}</h1>
    <p>{{postData.body}}</p>
    '''
        .trim(),
  );
  print('Added template: ${template.name}');

  // Add an HTTP data source for fetching a single post
  final dataSource = builder.addHttpDataSource(
    'postData',
    'https://jsonplaceholder.typicode.com/posts/{{id}}',
    method: 'GET',
  );
  print('Added HTTP data source: ${dataSource.name}');

  // Add a route for path "/posts/:id"
  final route = builder.addRoute(
    '/posts/:id',
    template: template,
    dataSources: [dataSource],
  );
  print('Added route: ${route.path}');

  // Add a Mustache template for displaying a list of posts
  final listTemplate = builder.addStringTemplate(
    'post_list_template',
    '''
    <h1>All Posts</h1>
    <ul>
      {{#posts}}
        <li><a href="/posts/{{id}}">{{title}}</a></li>
      {{/posts}}
      {{^posts}}
        <li>No posts found.</li>
      {{/posts}}
    </ul>
    '''
        .trim(),
  );
  print('Added list template: ${listTemplate.name}');

  // Add an HTTP data source for fetching all posts
  final listDataSource = builder.addHttpDataSource(
    'posts',
    'https://jsonplaceholder.typicode.com/posts',
    method: 'GET',
  );
  print('Added HTTP data source for list: ${listDataSource.name}');

  // Add a route for path "/posts"
  final listRoute = builder.addRoute(
    '/posts',
    template: listTemplate,
    dataSources: [listDataSource],
  );
  print('Added list route: ${listRoute.path}');

  // Build all entities
  await builder.build();
  print('SqliteUIBuilder build complete.');

  // Render the route for a specific post, e.g., /posts/1
  final router = UIRouter(db);
  final testPaths = ['/posts', '/posts/1', '/posts/2'];
  for (final path in testPaths) {
    print('Rendering route "$path":');
    try {
      final bytes = await router.renderRoute(path);
      final content = utf8.decode(bytes);
      print('Rendered content for $path:');
      print(content);
    } catch (e) {
      print('Error rendering route $path: $e');
    }
  }

  await db.close();
}
