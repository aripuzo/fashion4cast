import 'dart:convert';

import 'package:fashion4cast/models/user.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{

  //------------------------------------------------------------- Preference Constants ------------------------------------------------------------

  // Constants for Preference-Value's data-type
  static const String PREF_TYPE_BOOL = "BOOL";
  static const String PREF_TYPE_INTEGER = "INTEGER";
  static const String PREF_TYPE_DOUBLE = "DOUBLE";
  static const String PREF_TYPE_STRING = "STRING";

  // Constants for Preference-Name
  static const String PREF_IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String PREF_IS_WELCOMED = "IS_WELCOMED";
  static const String PREF_DEFAULT_PLACE = "DEFAULT_PLACE";
  static const String PREF_USER_DATA = "USER_DATA";
  static const String PREF_TOKEN = "TOKEN";
  static const String PREF_HAS_DEVICE = "HAS_DEVICE";
  static const String PREF_USE_F = "USE_F";
  static const String PREF_ALLOW_NOTIFICATION = "ALLOW_NOTIFICATION";
  static const String PREF_USE_CURRENT_LOCATION = "USE_CURRENT_LOCATION";

  //-------------------------------------------------------------------- Variables -------------------------------------------------------------------
  // Future variable to check SharedPreference Instance is ready
  // This is actually a hack. As constructor is not allowed to have 'async' we cant 'await' for future value
  // SharedPreference.getInstance() returns Future<SharedPreference> object and we want to assign its value to our private _preference variable
  // In case if we don't 'await' for SharedPreference.getInstance() method, and in mean time if we access preferences using _preference variable we will get
  // NullPointerException for _preference variable, as it isn't yet initialized.
  // We need to 'await' _isPreferenceReady value for only once when preferences are first time requested in application lifecycle because in further
  // future requests, preference instance is already ready as we are using Singleton-Instance.
  Future _isPreferenceInstanceReady;

  // Private variable for SharedPreferences
  SharedPreferences _preferences;


  //-------------------------------------------------------------------- Singleton ----------------------------------------------------------------------
  // Final static instance of class initialized by private constructor
  static final AppPreferences _instance = AppPreferences._internal();
  // Factory Constructor
  factory AppPreferences()=> _instance;

  /// AppPreference Private Internal Constructor -> AppPreference
  /// @param->_
  /// @usage-> Initialize SharedPreference object and notify when operation is complete to future variable.
  AppPreferences._internal(){
    _isPreferenceInstanceReady = SharedPreferences.getInstance().then((preferences)=> _preferences = preferences);
  }

  //------------------------------------------------------- Getter Methods -----------------------------------------------------------
  // GETTER for isPreferenceReady future
  Future get isPreferenceReady => _isPreferenceInstanceReady;

  //--------------------------------------------------- Public Preference Methods -------------------------------------------------------------

  /// Set Logged-In Method -> void
  /// @param -> @required isLoggedIn -> bool
  /// @usage -> Set value of IS_LOGGED_IN in preferences
  void setLoggedIn({@required bool isLoggedIn}) => _setPreference(prefName: PREF_IS_LOGGED_IN, prefValue: isLoggedIn, prefType: PREF_TYPE_BOOL);

  Future<bool> getLoggedIn() async => await _getPreference(prefName: PREF_IS_LOGGED_IN) ?? false;

  bool isLoggedIn() => _getPreferenceNow(prefName: PREF_IS_LOGGED_IN) ?? false;

  void setIsWelcomed({@required bool isWelcomed}) => _setPreference(prefName: PREF_IS_WELCOMED, prefValue: isWelcomed, prefType: PREF_TYPE_BOOL);

  bool isWelcomed() => _getPreferenceNow(prefName: PREF_IS_WELCOMED) ?? false;

  void setDefaultPlace({@required int placeId}) => _setPreference(prefName: PREF_DEFAULT_PLACE, prefValue: placeId, prefType: PREF_TYPE_INTEGER);

  int getDefaultPlace() => _getPreferenceNow(prefName: PREF_DEFAULT_PLACE) ?? null;

  void setUser({@required User user}) => _setPreference(prefName: PREF_USER_DATA, prefValue: jsonEncode(user), prefType: PREF_TYPE_STRING);

  User getUser() => User.fromJson(jsonDecode(_getPreferenceNow(prefName: PREF_USER_DATA)));

  void setToken({@required String token}) => _setPreference(prefName: PREF_TOKEN, prefValue: token, prefType: PREF_TYPE_STRING);

  String getToken() => _getPreferenceNow(prefName: PREF_TOKEN) ?? null;

  void setHasDevice({@required bool hasDevice}) => _setPreference(prefName: PREF_HAS_DEVICE, prefValue: hasDevice, prefType: PREF_TYPE_BOOL);

  bool hasDevice() => _getPreferenceNow(prefName: PREF_HAS_DEVICE) ?? false;

  void setUseF({@required bool hasDevice}) => _setPreference(prefName: PREF_USE_F, prefValue: hasDevice, prefType: PREF_TYPE_BOOL);

  bool useF() => _getPreferenceNow(prefName: PREF_USE_F) ?? true;

  void setAllowNotification({@required bool hasDevice}) => _setPreference(prefName: PREF_ALLOW_NOTIFICATION, prefValue: hasDevice, prefType: PREF_TYPE_BOOL);

  bool allowNotification() => _getPreferenceNow(prefName: PREF_ALLOW_NOTIFICATION) ?? true;

  void setUseCurrentLocation({@required bool hasDevice}) => _setPreference(prefName: PREF_USE_CURRENT_LOCATION, prefValue: hasDevice, prefType: PREF_TYPE_BOOL);

  bool useCurrentLocation() => _getPreferenceNow(prefName: PREF_USE_CURRENT_LOCATION) ?? true;

  Future<bool> logout() {
    return _preferences.clear();
  }


  //--------------------------------------------------- Private Preference Methods ----------------------------------------------------
  /// Set Preference Method -> void
  /// @param -> @required prefName -> String
  ///        -> @required prefValue -> dynamic
  ///        -> @required prefType -> String
  /// @usage -> This is a generalized method to set preferences with required Preference-Name(Key) with Preference-Value(Value) and Preference-Value's data-type.
  void _setPreference ({@required String prefName,@required dynamic prefValue,@required String prefType}){
    // Make switch for Preference Type i.e. Preference-Value's data-type
    switch(prefType){
    // prefType is bool
      case PREF_TYPE_BOOL:{
        _preferences.setBool(prefName, prefValue);
        break;
      }
    // prefType is int
      case PREF_TYPE_INTEGER:{
        _preferences.setInt(prefName, prefValue);
        break;
      }
    // prefType is double
      case PREF_TYPE_DOUBLE:{
        _preferences.setDouble(prefName, prefValue);
        break;
      }
    // prefType is String
      case PREF_TYPE_STRING:{
        _preferences.setString(prefName, prefValue);
        break;
      }
    }

  }

  /// Get Preference Method -> Future<dynamic>
  /// @param -> @required prefName -> String
  /// @usage -> Returns Preference-Value for given Preference-Name
  Future<dynamic> _getPreference({@required prefName}) async => _preferences.get(prefName);

  dynamic _getPreferenceNow({@required prefName}) => _preferences.get(prefName);

}