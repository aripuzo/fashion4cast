import 'dart:async';

import 'package:drift/drift.dart';
import 'package:fashion4cast/models/place_with_weather.dart';
import 'package:fashion4cast/models/temp_weather.dart';

import '../app_database.dart';

part 'weather_dao.g.dart';

@DriftAccessor(tables: [Weathers])
class WeatherDao extends DatabaseAccessor<MyDatabase> with _$WeatherDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  WeatherDao(MyDatabase db) : super(db);

  StreamController<List<TempWeather>> _weatherController = StreamController<List<TempWeather>>.broadcast();
  Stream<List<TempWeather>> get data => _weatherController.stream;
  List<TempWeather> _weathers = [];

  var _placeWeatherController = StreamController<List<PlaceWithWeather>>.broadcast();
  Stream<List<PlaceWithWeather>> get placeWeatherData => _placeWeatherController.stream;
  List<PlaceWithWeather> _placeWeathers = [];


  void _dispatch() {
    _weatherController.sink.add(_weathers);
    _placeWeatherController.sink.add(_placeWeathers);
  }


  void saveWeather(TempWeather weather) {
    _weathers.add(weather);
    _dispatch();
  }

  List<TempWeather> readData(){
    return _weathers;
  }

  void removeAll(){
    _weathers.clear();
    _dispatch();
  }

  void insert(TempWeather value, Place place) async {
    bool exist = false;
    for (int i = 0; i < _weathers.length; i++) {
      if(value.externalId == _weathers[i].externalId) {
        exist = true;
        break;
      }
    }
    if(true) {
      _weathers.add(value);
      _placeWeathers.add(PlaceWithWeather(place, value));
    }
    _dispatch();
  }

  void dispose() {
    _placeWeathers = null;
    _weathers = null;
    _weatherController.close();
    _placeWeatherController.close();
  }
}