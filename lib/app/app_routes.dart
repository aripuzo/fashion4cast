import 'package:fashion4cast/views/add_locations_view.dart';
import 'package:fashion4cast/views/change_password_view.dart';
import 'package:fashion4cast/views/complete_view.dart';
import 'package:fashion4cast/views/edit_profile_view.dart';
import 'package:fashion4cast/views/forgot_password_view.dart';
import 'package:fashion4cast/views/login_view.dart';
import 'package:fashion4cast/views/main_view.dart';
import 'package:fashion4cast/views/main_view2.dart';
import 'package:fashion4cast/views/register_view.dart';
import 'package:fashion4cast/views/reset_password_view.dart';
import 'package:fashion4cast/views/select_locations_view.dart';
import 'package:fashion4cast/views/settings_view.dart';
import 'package:fashion4cast/views/single_weather_view.dart';
import 'package:fashion4cast/views/splash_view.dart';
import 'package:fashion4cast/views/terms_view.dart';
import 'package:fashion4cast/views/weekly_forecast_view.dart';
import 'package:fashion4cast/views/weekly_suggestion_view.dart';
import 'package:fashion4cast/views/welcome_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App Routes Class -> Routing class
class AppRoutes{

  //--------------------------------------------------------------- Constants ------------------------------------------------------------------------
  static const String APP_ROUTE_LOGIN = "/login";
  static const String APP_ROUTE_REGISTER = "/register";
  static const String APP_ROUTE_FORGOT_PASSWORD = "/forgot_password";
  static const String APP_ROUTE_RESET_PASSWORD = "/reset_password";
  static const String APP_ROUTE_MAIN = "/main";
  static const String APP_ROUTE_MAIN2 = "/main2";
  static const String APP_ROUTE_WELCOME = "/welcome";
  static const String APP_ROUTE_COMPLETE = "/complete";
  static const String APP_ROUTE_WEEKLY_FORECAST = "/weekly_forecast";
  static const String APP_ROUTE_SETTINGS = "/settings";
  static const String APP_ROUTE_EDIT_PROFILE = "/edit_profile";
  static const String APP_ROUTE_SELECT_CITIES = "/select_cities";
  static const String APP_ROUTE_ADD_LOCATIONS = "/add_locations";
  static const String APP_ROUTE_TERMS = "/terms";
  static const String APP_ROUTE_CHANGE_PASSWORD = "/change_password";
  static const String APP_ROUTE_WEEKLY_SUGGESTION = "/weekly_suggestion";
  static const String APP_ROUTE_SINGLE_WEATHER = "/single_weather";

  //--------------------------------------------------------------- Methods --------------------------------------------------------------------------

  /// Get Routes Method -> Route
  /// @param -> routeSettings -> RouteSettings
  /// @usage -> Returns route based on requested route settings
  Route getRoutes(RouteSettings routeSettings){

    switch(routeSettings.name){

      case APP_ROUTE_WELCOME : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Welcome(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_LOGIN : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Login(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_REGISTER : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Register(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_FORGOT_PASSWORD : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => ForgotPassword(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_RESET_PASSWORD : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => ResetPassword(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_COMPLETE : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Complete(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_MAIN : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Main(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_MAIN2 : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Main2(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_SETTINGS : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Settings(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_TERMS : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Terms(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_EDIT_PROFILE : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => EditProfile(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_CHANGE_PASSWORD : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => ChangePassword(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_SELECT_CITIES : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => SelectLocations(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_WEEKLY_FORECAST : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => WeeklyForecast(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_WEEKLY_SUGGESTION : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => WeeklySuggestion(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_SINGLE_WEATHER : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => SingleWeather(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_ADD_LOCATIONS : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => AddLocations(),
          fullscreenDialog: true,
        );
      }

      default: {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Splash(),
          fullscreenDialog: true,
        );
      }

    }

  }

}