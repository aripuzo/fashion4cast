import 'dart:io';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dao/place_dao.dart';
import 'dao/weather_dao.dart';

part 'app_database.g.dart';

class Places extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  TextColumn get description => text().nullable()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  TextColumn get external_id => text()();
  TextColumn get body => text().named('map').nullable()();
}

class Weathers extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get day => text().nullable()();
  RealColumn get minTemp => real().nullable()();
  RealColumn get maxTemp => real().nullable()();
  TextColumn get date => text().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get timestamp => text().nullable()();
  BoolColumn get isToday => boolean().nullable()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [Places, Weathers], daos: [PlaceDao, WeatherDao])
class MyDatabase extends _$MyDatabase {
  //MyDatabase(QueryExecutor e) : super(e);

  MyDatabase() : super(_openConnection());


  @override
  int get schemaVersion => 3;
}