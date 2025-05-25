import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:sqlite3/common.dart';

bool routeMatches(String route, String pattern) {
  // print('Checking if route "$route" matches pattern "$pattern"');
  if (route == pattern) return true;
  // Check if the route matches the pattern
  final pathRegExp = pathToRegExp(pattern);
  return pathRegExp.regexp.hasMatch(route);
}

void initFunctions(CommonDatabase db) {
  // Register the function to check if a route matches a pattern
  db.createFunction(
    functionName: 'route_matches',
    function: (args) {
      if (args.length != 2) {
        throw ArgumentError('route_matches requires exactly 2 arguments');
      }
      final [route as String, pattern as String] = args;
      return routeMatches(route, pattern) ? 1 : 0;
    },
    argumentCount: AllowedArgumentCount(2),
    deterministic: true,
    directOnly: true,
  );
}
