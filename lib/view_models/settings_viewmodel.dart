import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/user.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../databases/app_database.dart';
import '../repository/user_repository.dart';


class SettingsViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  UserRepository _userRepository;
  AppPreferences _appPreferences;

  static SettingsViewModel _instance;
  // STREAM CONTROLLER for broadcasting login response
  var _myPlacesController = StreamController<List<Place>>.broadcast();
  bool useF;
  bool allowNot;
  bool useCurrentLocation;
  StreamingSharedPreferences preferences;

  User user;

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory SettingsViewModel(App app){
    _instance
    ??= // NULL Check
    SettingsViewModel._internal(userRepository: app.getUserRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  SettingsViewModel._internal({@required UserRepository userRepository}){
    //_registerFormObserver = registerFormObserver;
    _userRepository = userRepository;
    _appPreferences = App().getAppPreferences();
    StreamingSharedPreferences.instance.then((value) => preferences = value);
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    useF = _appPreferences.useF();
    allowNot = _appPreferences.allowNotification();
    useCurrentLocation = _appPreferences.useCurrentLocation();

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

  void setUseCurrentLocation(bool val){
    _appPreferences.setUseCurrentLocation(hasDevice: val);
    useCurrentLocation = val;
  }

  void deleteAccount(){
    _userRepository.deleteAccount();
  }

  void logout() {
    App().logout();
  }

  Stream<List<Place>> getMyPlaces() => _myPlacesController.stream;

}