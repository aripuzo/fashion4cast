import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/user.dart';
import 'package:fashion4cast/repository/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SettingsViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  //LocationRepository _locationRepository;
  AppPreferences _appPreferences;

  static SettingsViewModel _instance;
  // STREAM CONTROLLER for broadcasting login response
  var _myPlacesController = StreamController<List<Place>>.broadcast();
  bool useF;
  bool allowNot;
  StreamingSharedPreferences preferences;

  User user;

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory SettingsViewModel(App app){
    _instance
    ??= // NULL Check
    SettingsViewModel._internal(gamePlayRepository: app.getLocationRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  SettingsViewModel._internal({@required LocationRepository gamePlayRepository}){
    //_registerFormObserver = registerFormObserver;
    //_locationRepository = gamePlayRepository;
    _appPreferences = App().getAppPreferences();
    StreamingSharedPreferences.instance.then((value) => preferences = value);
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    useF = _appPreferences.useF();
    allowNot = _appPreferences.allowNotification();

    user = App().getAppPreferences().getUser();
  }

  void setUseF(bool val){
    preferences.setBool(AppPreferences.PREF_USE_F, val);
    //_appPreferences.setUseF(hasDevice: val);
    useF = val;
  }

  void setAllowNotification(bool val){
    _appPreferences.setAllowNotification(hasDevice: val);
    allowNot = val;
  }

  void logout() {
    App().logout();
  }

  Stream<List<Place>> getMyPlaces() => _myPlacesController.stream;

}