import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/models/alert.dart';
import 'package:fashion4cast/models/place_with_weather.dart';
import 'package:fashion4cast/repository/weather_repository.dart';
import 'package:flutter/material.dart';

class SingleWeatherViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  WeatherRepository _weatherRepository;
  //StreamingSharedPreferences preferences;

  static SingleWeatherViewModel _instance;
  // STREAM CONTROLLER for broadcasting login response
  var _myPlacesController = StreamController<List<PlaceWithWeather>>.broadcast();
  var _alertController = StreamController<List<Alert>>.broadcast();
  var _logoutController = StreamController<bool>.broadcast();
  var _emptyLocationController = StreamController<bool>.broadcast();

  bool done = false;

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory SingleWeatherViewModel(App app){
    _instance
    ??= // NULL Check
    SingleWeatherViewModel._internal(weatherRepository: app.getWeatherRepository(appPreferences: app.getAppPreferences()),
    );
    return _instance;
  }

  SingleWeatherViewModel._internal({@required WeatherRepository weatherRepository}){
    //_registerFormObserver = registerFormObserver;
    _weatherRepository = weatherRepository;
    //StreamingSharedPreferences.instance.then((value) => preferences = value);
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    _listenRegisterResponse();
  }

  void _listenRegisterResponse(){
    _weatherRepository.getPlaceWithWeather()
        .listen(
            (places){
          _myPlacesController.add(places);
        }
    );

    _weatherRepository.getAlerts()
        .listen(
            (alerts){
          _alertController.add(alerts);
        }
    );
  }

  Stream<List<PlaceWithWeather>> getCurrentWeathers() => _myPlacesController.stream;

  Stream<bool> isLogout() => _logoutController.stream;

  Stream<bool> getEmptyLocation() => _emptyLocationController.stream;

  Stream<List<Alert>> getAlerts() => _alertController.stream;

  //Preference<bool> getUseF() => _preferences.getBool(AppPreferences.PREF_USE_F, defaultValue: true);

}