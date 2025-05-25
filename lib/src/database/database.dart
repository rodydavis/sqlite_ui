import 'package:drift/drift.dart';

part 'database.g.dart';

@DriftDatabase(include: {
  'sql/schema.drift',
  'sql/queries.drift',
  'sql/mutations.drift',
})
class UIDatabase extends _$UIDatabase {
  UIDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
