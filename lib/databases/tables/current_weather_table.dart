import 'package:moor/moor.dart';

class CurrentWeathers extends Table {
  IntColumn get placeId => integer().customConstraint('UNIQUE').nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get summery => text().nullable()();
  TextColumn get icon => text().nullable()();
  RealColumn get pressure => real().nullable()();
  RealColumn get temperature => real().nullable()();
  RealColumn get humidity => real().nullable()();
  RealColumn get pressure_daily => real().nullable()();
  RealColumn get chance_of_rain => real().nullable()();
  IntColumn get wind_direction => integer().nullable()();
  TextColumn get external_id => text().nullable()();
  TextColumn get background => text().nullable()();
  BoolColumn get alert => boolean().nullable()();

  RealColumn get min_temp => real().nullable()();
  RealColumn get wind_speed => real().nullable()();
  RealColumn get max_temp => real().nullable()();
  BoolColumn get is_today => boolean().nullable()();
  TextColumn get day => text().nullable()();
  TextColumn get date => text().nullable()();

  @override
  Set<Column> get primaryKey => {placeId};
}