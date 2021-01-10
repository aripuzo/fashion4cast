import 'dart:io';

import 'package:fashion4cast/databases/dao/current_weather_dao.dart';
import 'package:fashion4cast/databases/dao/weather_dao.dart';
import 'package:fashion4cast/databases/tables/current_weather_table.dart';
import 'package:fashion4cast/databases/tables/places_table.dart';
import 'package:fashion4cast/databases/tables/weathers_table.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dao/place_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Places, Weathers, CurrentWeathers],
    daos: [PlaceDao, WeatherDao, CurrentWeatherDao])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}