import 'dart:async';

import 'package:fashion4cast/models/place.dart';
import 'package:fashion4cast/models/place_with_weather.dart';
import 'package:fashion4cast/models/temp_weather.dart';

class WeatherDao {
  StreamController<List<TempWeather>> _weatherController = StreamController<List<TempWeather>>.broadcast();
  Stream<List<TempWeather>> get data => _weatherController.stream;
  List<TempWeather> _weathers = [];

  var _placeWeatherController = StreamController<List<PlaceWithWeather>>.broadcast();
  Stream<List<PlaceWithWeather>> get placeWeatherData => _placeWeatherController.stream;
  List<PlaceWithWeather> _placeWeathers = [];

  //-------------------------------------------------------------------- Singleton ----------------------------------------------------------------------
  // Final static instance of class initialized by private constructor
  static final WeatherDao _instance = WeatherDao._internal();
  // Factory Constructor
  factory WeatherDao()=> _instance;

  /// AppPreference Private Internal Constructor -> AppPreference
  /// @param->_
  /// @usage-> Initialize SharedPreference object and notify when operation is complete to future variable.
  WeatherDao._internal();


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
      if(value.id == _weathers[i].id) {
        exist = true;
        break;
      }
    }
    if(!exist) {
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