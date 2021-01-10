import 'package:fashion4cast/databases/tables/weathers_table.dart';
import 'package:fashion4cast/models/temp_weather.dart';
import 'package:moor/moor.dart';

import '../app_database.dart';

part 'weather_dao.g.dart';

@UseDao(tables: [Weathers])
class WeatherDao extends DatabaseAccessor<AppDatabase> with _$WeatherDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  WeatherDao(this.db) : super(db);

  Future<List<Weather>> getProducts() => select(weathers).get();

  Future<List<Weather>> getWeathers(int placeId) {
    return (select(weathers)..where((t) => t.placeId.equals(placeId))).get();
  }

  Stream<List<Weather>> watchAllWeathers(int placeId) {
    // where returns void, need to use the cascading operator
    return (select(weathers)
      ..orderBy(
        ([
          // Primary sorting by due date
              (w) =>
              OrderingTerm(expression: w.timestamp, mode: OrderingMode.asc),
          // Secondary alphabetical sorting
              //(t) => OrderingTerm(expression: t.day),
        ]),
      )
      ..where((t) => t.placeId.equals(placeId)))
        .watch();
  }

  Future insertWeather(Weather weather) => into(weathers).insert(weather);

  Future updateWeather(Weather weather) => update(weathers).replace(weather);

  Future deleteWeather(Weather weather) => delete(weathers).delete(weather);

  Future<void> insertWeathers(List<TempWeather> qs, int placeId) async{
    for(int i = 0; i < qs.length; i++){
      var weather = qs[i].toWeather(placeId);
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

  Future<void> deleteAllProducts() async{
    var products = await getProducts();
    if(products != null)
      for(int i = 0; i < products.length; i++){
        deleteWeather(products[i]);
      }
  }

  Future<void> replaceWeathers(List<TempWeather> places, int placedId) async {
    await deleteAllProducts();
    await deleteAllWeathers(placedId);
    await insertWeathers(places, placedId);
  }
}