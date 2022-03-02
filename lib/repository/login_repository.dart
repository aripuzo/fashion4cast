import 'dart:async';

import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/databases/dao/place_dao.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:meta/meta.dart';

class LoginRepository {

  var _isSuccessfulLogin = StreamController<String>.broadcast();
  AppPreferences _appPreferences;
  factory LoginRepository({@required AppPreferences appPreferences})=> LoginRepository._internal(appPreferences);

  LoginRepository._internal(this._appPreferences);

  void isAuthenticUser(
      {@required String userName, @required String userPassword}) {
    Api.initialize().singIn(email: userName, password: userPassword).then((result) {
      if (result != null && result.data != null && result.errors != true) {
        var user = result.data;
        _appPreferences.setLoggedIn(isLoggedIn: true);
        _appPreferences.setToken(token: user.token);
        _appPreferences.setUser(user: user);
        _isSuccessfulLogin.add(null);
        loadMyPlaces();
      } else {
        String message = (result != null && result.message != null)
            ? result.message : AppStrings.LOGIN_UNSUCCESSFUL_LOGIN_MSG;
        _isSuccessfulLogin.add(message);
        _appPreferences.setLoggedIn(isLoggedIn: false);
      }
    });
  }

  Stream<String> getLoginResponse() {
    return _isSuccessfulLogin.stream;
  }

  void loadMyPlaces(){
    var placeDao = PlaceDao();
    Api.initialize().getMyPlaces()
        .then((result) {
      if (result != null && result.data.data.isNotEmpty) {
        placeDao.insertMore(result.data.data);
      }
    });
  }

}