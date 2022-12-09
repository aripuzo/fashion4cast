import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/repository/ad_repository.dart';
import 'package:fashion4cast/repository/forgot_password_repository.dart';
import 'package:fashion4cast/repository/location_repository.dart';
import 'package:fashion4cast/repository/login_repository.dart';
import 'package:fashion4cast/repository/product_repository.dart';
import 'package:fashion4cast/repository/register_repository.dart';
import 'package:fashion4cast/repository/reset_password_repository.dart';
import 'package:fashion4cast/repository/user_repository.dart';
import 'package:fashion4cast/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../databases/app_database.dart';
import '../databases/dao/place_dao.dart';
import '../databases/dao/weather_dao.dart';
import 'app_routes.dart';

/// App Class -> Application Class
class App extends StatelessWidget {
  //-------------------------------------------------------------- Singleton-Instance --------------------------------------------------------------
  // Singleton-Instance
  static final App _instance = App._internal();

  /// App Private Constructor -> App
  /// @param -> _
  /// @usage -> Create Instance of App
  App._internal();

  /// App Factory Constructor -> App
  /// @dependency -> _
  /// @usage -> Returns the instance of app
  factory App() => _instance;

  bool _requireConsent = true;

  MyDatabase appDatabase;

  //------------------------------------------------------------ Widget Methods --------------------------------------------------------------------

  /// @override Build Method -> Widget
  /// @param -> context -> BuildContext
  /// @returns -> Returns widget as MaterialApp class instance
  @override
  Widget build(BuildContext context) {
    initPlatformState();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: getAppRoutes().getRoutes,
    );
  }

  //------------------------------------------------------------- App Methods -------------------------------------------------------------------------

  /// Get App Routes Method -> AppRoutes
  /// @param -> _
  /// @usage -> Returns the instance of AppRoutes class
  AppRoutes getAppRoutes(){
    return AppRoutes();
  }

  /// Get App Preferences Method -> AppPreferences
  /// @param -> _
  /// @usage -> Returns the instance of AppPreferences class
  AppPreferences getAppPreferences(){
    return AppPreferences();
  }

  void logout() {
    var _appPreferences = getAppPreferences();
    _appPreferences.setLoggedIn(isLoggedIn: false);
    _appPreferences.setToken(token: null);
    _appPreferences.setUser(user: null);
    _appPreferences.logout();
    //PlaceDao().removeAll();
  }

  final database = MyDatabase();

  WeatherDao weatherDao;

  MyDatabase getAppDatabase() {
    return database;
  }

  WeatherDao getWeatherDao(){
    if (weatherDao == null)
      weatherDao = WeatherDao(database);
    return weatherDao;
  }

  PlaceDao getPlaceDao(){
    return PlaceDao(database);
  }
//
  /// Get Login Repository Method -> LoginRepository
  /// @param -> appPreferences -> AppPreferences
  /// @usage -> Returns the instance of LoginRepository class by injecting AppPreferences dependency
  LoginRepository getLoginRepository({@required AppPreferences appPreferences}){
    return LoginRepository(appPreferences: appPreferences);
  }

  RegisterRepository getRegisterRepository({@required AppPreferences appPreferences}){
    return RegisterRepository(appPreferences: appPreferences);
  }

  ForgotPasswordRepository getForgotPasswordRepository({AppPreferences appPreferences}) {
    return ForgotPasswordRepository(appPreferences: appPreferences);
  }

  ResetPasswordRepository getResetPasswordRepository({AppPreferences appPreferences}) {
    return ResetPasswordRepository(appPreferences: appPreferences);
  }

  LocationRepository getLocationRepository({AppPreferences appPreferences}) {
    return LocationRepository(appPreferences: appPreferences);
  }

  WeatherRepository getWeatherRepository({AppPreferences appPreferences}) {
    return WeatherRepository(appPreferences: appPreferences);
  }

  ProductRepository getProductRepository({AppPreferences appPreferences}) {
    return ProductRepository(appPreferences: appPreferences);
  }

  UserRepository getUserRepository({AppPreferences appPreferences}) {
    return UserRepository(appPreferences: appPreferences);
  }

  AdRepository getAdRepository({AppPreferences appPreferences}) {
    return AdRepository(appPreferences: appPreferences);
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("380dc082-5231-4cc2-ab51-a03da5a0e4c2");
  }

}