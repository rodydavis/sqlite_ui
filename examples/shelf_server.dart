import 'dart:io';

import 'package:drift/native.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:sqlite_ui/sqlite_ui.dart';

final globalCss = r'''
html {
  color-scheme: light dark;
}
body {
  font-family: Arial, sans-serif;
  margin: 20px;
}
''';

final postsCss = r'''
h1 {
  color: light-dark(#333, #fff);
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  margin: 5px 0;
}
a {
  text-decoration: none;
  color: light-dark(#007BFF, #66A0FF);
}
a:hover {
  text-decoration: underline;
}
input[type="search"] {
  margin-bottom: 10px;
  padding: 5px;
  width: 100%;
}
''';

final searchJs = r'''
const searchInput = document.getElementById('search');
const postsList = document.getElementById('posts-list');

searchInput.addEventListener('input', function() {
  const filter = searchInput.value.toLowerCase();
  const posts = postsList.getElementsByTagName('li');

  for (let i = 0; i < posts.length; i++) {
    const post = posts[i].getElementsByTagName('a')[0];
    if (post.innerHTML.toLowerCase().indexOf(filter) > -1) {
      posts[i].style.display = '';
    } else {
      posts[i].style.display = 'none';
    }
  }
});
''';

Future<void> main() async {
  final db = UIDatabase(NativeDatabase.memory(
    setup: initUIFunctions,
  ));
  final builder = UIBuilder(db);

  final globalStyle = builder.addStringAsset(
    'global.css',
    globalCss.trim(),
    mimeType: 'text/css',
  );
  final globalStyleRoute = builder.addRoute(
    '/assets/${globalStyle.name}',
    asset: globalStyle,
  );

  // Add a Mustache template for displaying a post
  final template = builder.addStringTemplate(
    'post_template',
    '''
<link rel="stylesheet" href="${globalStyleRoute.path}">
<h1>Post {{postData.id}}: {{postData.title}}</h1>
<p>{{postData.body}}</p>
<p><a href="/posts">Back to all posts</a></p>
'''
        .trim(),
  );

  // Add an HTTP data source for fetching a single post
  final dataSource = builder.addHttpDataSource(
    'postData',
    'https://jsonplaceholder.typicode.com/posts/{{id}}',
    method: 'GET',
  );
  // Add a route for path "/posts/:id"
  builder.addRoute(
    '/posts/:id',
    template: template,
    dataSources: [dataSource],
  );

  final postsStyle = builder.addStringAsset(
    'posts.css',
    postsCss.trim(),
    mimeType: 'text/css',
  );
  final postsStyleRoute = builder.addRoute(
    '/assets/${postsStyle.name}',
    asset: postsStyle,
  );

  // client side search
  final searchScript = builder.addStringAsset(
    'search.js',
    searchJs.trim(),
    mimeType: 'application/javascript',
  );
  final searchRoute = builder.addRoute(
    '/assets/${searchScript.name}',
    asset: searchScript,
  );

  // Add a Mustache template for displaying a list of posts
  final listTemplate = builder.addStringTemplate(
    'post_list_template',
    '''
<link rel="stylesheet" href="${globalStyleRoute.path}">
<link rel="stylesheet" href="${postsStyleRoute.path}">
<h1>All Posts</h1>
<input type="search" id="search" placeholder="Search posts..." />
<ul id="posts-list">
  {{#posts}}
    <li><a href="/posts/{{id}}">{{title}}</a></li>
  {{/posts}}
  {{^posts}}
    <li>No posts found.</li>
  {{/posts}}
</ul>
<script src="${searchRoute.path}" type="application/javascript"></script>
'''
        .trim(),
  );

  // Add an HTTP data source for fetching all posts
  final listDataSource = builder.addHttpDataSource(
    'posts',
    'https://jsonplaceholder.typicode.com/posts',
    method: 'GET',
  );
  // Add a route for path "/posts"
  builder.addRoute(
    '/posts',
    template: listTemplate,
    dataSources: [listDataSource],
  );
  builder.addRoute(
    '/',
    redirectTo: '/posts',
  );
  // Build all entities
  await builder.build();
  final router = UIRouter(db);

  final handler = const Pipeline() //
      .addMiddleware(logRequests())
      .addHandler((req) => _handler(router, req));

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  print('Serving SQLite UI on http://localhost:${server.port}');
}

Future<Response> _handler(UIRouter router, Request request) async {
  try {
    final route = await router.getRoute('/${request.url.path}');
    if (route is MissingRouteResult) {
      return Response.notFound('Route not found: ${route.path}');
    }
    if (route is RedirectResult) {
      return Response.movedPermanently(route.redirectTo);
    }
    if (route is AssetResult) {
      return Response.ok(
        route.content,
        headers: {'content-type': route.mimeType},
      );
    }
    if (route is TemplateResult) {
      return Response.ok(
        route.content,
        headers: {'content-type': 'text/html; charset=utf-8'},
      );
    }
    throw Exception('Unknown route result type');
  } catch (e) {
    return Response.internalServerError(body: 'Error rendering route: $e');
  }
}
