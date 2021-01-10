import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/dao/current_weather_dao.dart';
import 'package:fashion4cast/models/alert.dart';
import 'package:fashion4cast/repository/location_repository.dart';
import 'package:fashion4cast/repository/user_repository.dart';
import 'package:fashion4cast/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MainViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  WeatherRepository _weatherRepository;
  LocationRepository _placeRepository;
  UserRepository _userRepository;
  StreamingSharedPreferences preferences;

  static MainViewModel _instance;
  // STREAM CONTROLLER for broadcasting login response
  var _myPlacesController = StreamController<List<PlaceWithWeather>>.broadcast();
  var _alertController = StreamController<List<Alert>>.broadcast();
  var _logoutController = StreamController<bool>.broadcast();
  var _emptyLocationController = StreamController<bool>.broadcast();

  bool done = false;

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory MainViewModel(App app){
    _instance
    ??= // NULL Check
    MainViewModel._internal(weatherRepository: app.getWeatherRepository(appPreferences: app.getAppPreferences()),
        placeRepository: app.getLocationRepository(appPreferences: app.getAppPreferences()),
        userRepository: app.getUserRepository(appPreferences: app.getAppPreferences())
    );
    return _instance;
  }

  MainViewModel._internal({@required WeatherRepository weatherRepository,
    @required LocationRepository placeRepository, @required UserRepository userRepository}){
    //_registerFormObserver = registerFormObserver;
    _weatherRepository = weatherRepository;
    _placeRepository = placeRepository;
    _userRepository = userRepository;
    StreamingSharedPreferences.instance.then((value) => preferences = value);
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    _listenRegisterResponse();
  }

  void refreshWeather() async{
    _placeRepository.loadMyPlaces();
  }

  void addDevice(String deviceId){
    _userRepository.addDevice(deviceId: deviceId);
  }

  void _listenRegisterResponse(){
    _weatherRepository.getPlaceWithWeather()
        .listen(
            (places){
          _myPlacesController.add(places);
        }
    );

    _placeRepository.getLogoutError().listen((event) {
      if(event == true){
        App().logout();
        _logoutController.add(event);
      }
    });

    _placeRepository.getEmptyLocationError().listen((event) {
      if(event){
        _emptyLocationController.add(event);
      }
    });

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