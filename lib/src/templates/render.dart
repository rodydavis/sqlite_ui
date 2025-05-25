import 'package:mustache_template/mustache_template.dart';

String renderTemplate(
  String source, {
  Object values = const {},
  bool lenient = false,
  bool htmlEscapeValues = true,
  String name = '',
  Template? Function(String)? partialResolver,
  String delimiters = '{{ }}',
}) {
  final template = Template(
    source,
    lenient: lenient,
    htmlEscapeValues: htmlEscapeValues,
    name: name,
    partialResolver: partialResolver,
    delimiters: delimiters,
  );
  return template.renderString(values);
}
