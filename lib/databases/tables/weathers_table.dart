import 'package:moor/moor.dart';

class Weathers extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  IntColumn get placeId => integer().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get summery => text().nullable()();
  TextColumn get icon => text().nullable()();
  IntColumn get timestamp => integer().nullable()();

  RealColumn get min_temp => real().nullable()();
  RealColumn get max_temp => real().nullable()();
  BoolColumn get is_today => boolean().nullable()();
  TextColumn get day => text().nullable()();
  TextColumn get date => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}