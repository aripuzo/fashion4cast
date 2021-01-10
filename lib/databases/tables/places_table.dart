import 'package:moor/moor.dart';

class Places extends Table {
  IntColumn get id => integer().customConstraint('UNIQUE')();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  TextColumn get external_id => text().nullable().customConstraint('UNIQUE')();

  @override
  Set<Column> get primaryKey => {id};
}