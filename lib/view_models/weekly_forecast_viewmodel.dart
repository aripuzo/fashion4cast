import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/network/models/detail_weather_result.dart';
import 'package:fashion4cast/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../databases/app_database.dart';


class WeeklyForecastViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  WeatherRepository _weatherRepository;
  StreamingSharedPreferences preferences;

  static WeeklyForecastViewModel _instance;
  var _myPlacesController = StreamController<DetailWeather>.broadcast();
  var _placesErrorController = StreamController<bool>.broadcast();

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory WeeklyForecastViewModel(App app){
    _instance
    ??= // NULL Check
    WeeklyForecastViewModel._internal(weatherRepository: app.getWeatherRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  WeeklyForecastViewModel._internal({@required WeatherRepository weatherRepository}){
    _weatherRepository = weatherRepository;
    StreamingSharedPreferences.instance.then((value) => preferences = value);
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    _listenRegisterResponse();
  }

  void refreshWeather(Place place){
    _weatherRepository.loadWeather(placeId: place.external_id);
  }

  void _listenRegisterResponse(){
    _weatherRepository.getDetailWeather()
        .listen(
            (places){
          _myPlacesController.add(places);
        }
    );
    _weatherRepository.getError().listen((event) {
      _placesErrorController.add(event);
    });
  }

  Stream<DetailWeather> getWeathers() => _myPlacesController.stream;

  Stream<bool> getError() => _placesErrorController.stream;

}