import 'package:fashion4cast/databases/tables/current_weather_table.dart';
import 'package:fashion4cast/models/temp_weather.dart';
import 'package:moor/moor.dart';

import '../app_database.dart';

part 'current_weather_dao.g.dart';

@UseDao(tables: [CurrentWeathers])
class CurrentWeatherDao extends DatabaseAccessor<AppDatabase> with _$CurrentWeatherDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  CurrentWeatherDao(this.db) : super(db);

  Future<List<CurrentWeather>> getWeathers(int placeId) {
    return (select(currentWeathers)..where((t) => t.placeId.equals(placeId))).get();
  }

  Stream<List<CurrentWeather>> watchAllWeathers(int placeId) {
    // where returns void, need to use the cascading operator
    return (select(currentWeathers)
      ..orderBy(
        ([
          // Primary sorting by due date
              (w) =>
              OrderingTerm(expression: w.date, mode: OrderingMode.desc),
          // Secondary alphabetical sorting
              (t) => OrderingTerm(expression: t.day),
        ]),
      )
      ..where((t) => t.placeId.equals(placeId)))
        .watch();
  }

  Future insertWeather(CurrentWeather weather) => into(currentWeathers).insert(weather);

  Future updateWeather(CurrentWeather weather) => update(currentWeathers).replace(weather);

  Future deleteWeather(CurrentWeather weather) => delete(currentWeathers).delete(weather);

  Future<void> insertWeathers(List<TempWeather> qs, int placeId) async{
    for(int i = 0; i < qs.length; i++){
      var weather = qs[i].toCurrentWeather(placeId);
      insertWeather(weather);
    }
  }

  Future<void> deleteAllWeathers(int placeId) async{
    var places = await getWeathers(placeId);
    if(places != null)
    for(int i = 0; i < places.length; i++){
      deleteWeather(places[i]);
    }
  }

  Future<void> replaceWeather(TempWeather weather, int placedId) async {
    await deleteAllWeathers(placedId);
    await insertWeather(weather.toCurrentWeather(placedId));
  }

  Stream<List<PlaceWithWeather>> placeWithWeather() {
    final query = select(db.places).join([
      leftOuterJoin(currentWeathers, currentWeathers.placeId.equalsExp(db.places.id)),
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return PlaceWithWeather(
          row.readTable(db.places),
          row.readTable(currentWeathers),
        );
      }).toList();
    });
  }
}

class PlaceWithWeather {

  PlaceWithWeather(this.place, this.weather);

  final Place place;
  final CurrentWeather weather;
}