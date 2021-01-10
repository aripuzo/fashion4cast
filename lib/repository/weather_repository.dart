import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/databases/dao/current_weather_dao.dart';
import 'package:fashion4cast/models/alert.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:fashion4cast/network/models/detail_weather_result.dart';
import 'package:meta/meta.dart';

class WeatherRepository {

  AppPreferences _appPreferences;
  var _alertController = StreamController<List<Alert>>.broadcast();
  var _placeWeatherController = StreamController<DetailWeather>.broadcast();
  var _placeWeatherErrorController = StreamController<bool>.broadcast();
  factory WeatherRepository({@required AppPreferences appPreferences})=> WeatherRepository._internal(appPreferences);

  WeatherRepository._internal(this._appPreferences);

  void getCurrentWeather({@required String placeId}) async{
    Api.initialize().getWeatherCurrent(placeId).then((result) {
      if (result != null && result.data != null) {
        var weatherDao = App().appDatabase.currentWeatherDao;
        weatherDao.replaceWeather(result.data.weather, result.data.place.id);
        if(result.data.weather.alert != null && result.data.weather.alert.isNotEmpty)
          _alertController.add(result.data.weather.alert);
      }
    });
  }

  void loadWeather({@required String placeId}) async{
    Api.initialize().getWeatherDetail(placeId).then((result) {
      if (result != null && result.data != null) {
        _placeWeatherController.add(result.data);
      }
      else{
        _placeWeatherErrorController.add(true);
      }
    }).catchError((error) {
      _placeWeatherErrorController.add(true);
    });
  }

  Stream<DetailWeather> getDetailWeather() => _placeWeatherController.stream;

  Stream<List<PlaceWithWeather>> getPlaceWithWeather() {
    return App().appDatabase.currentWeatherDao.placeWithWeather();
  }

  Stream<List<Weather>> getWeather(int placeId) {
    return App().appDatabase.weatherDao.watchAllWeathers(placeId);
  }

  Stream<List<Alert>> getAlerts() => _alertController.stream;

  Stream<bool> getError() => _placeWeatherErrorController.stream;

}