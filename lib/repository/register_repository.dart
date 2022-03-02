import 'dart:async';

import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:meta/meta.dart';

class RegisterRepository {

  var _isSuccessfulRegister = StreamController<Map<String, String>>.broadcast();
  AppPreferences _appPreferences;
  factory RegisterRepository({@required AppPreferences appPreferences})=> RegisterRepository._internal(appPreferences);

  RegisterRepository._internal(this._appPreferences);

  void registerUser(
      {@required String firstName, @required String lastName,
        @required String userEmail,
        @required String userPhone, @required String countryCode,
        @required String userPassword}) {
    Api.initialize().createUserDio(firstName: firstName, lastName: lastName,
    userEmail: userEmail, userPhone: userPhone, countryCode: countryCode,
    userPassword: userPassword).then((result) {
      if (result != null && result.data != null) {
        var user = result.data;
        _appPreferences.setLoggedIn(isLoggedIn: true);
        _appPreferences.setToken(token: user.token);
        _appPreferences.setUser(user: user);
        _isSuccessfulRegister.add(null);
      } else {
        Map<String, String> message;
        if(result != null) {
          var errors = result.errors;
          if (errors != null) {
            message = Map();
            if (errors.email != null && errors.email.isNotEmpty)
              message['email'] = errors.email[0];
            if (errors.phone != null && errors.phone.isNotEmpty)
              message['phone'] = errors.phone[0];
            if (errors.password != null && errors.password.isNotEmpty)
              message['password'] = errors.password[0];
          }
        }
        if(result != null && (message == null || message.isEmpty)) {
          if(message == null) message = Map();
          message["message"] = result.message;
        }
        else if(message == null) {
          message = Map();
          message["message"] = AppStrings.REGISTER_UNSUCCESSFUL_REGISTER_MSG;
        }

        _isSuccessfulRegister.add(message);
        _appPreferences.setLoggedIn(isLoggedIn: false);
      }
    });
  }

  Stream<Map<String, String>> getRegisterResponse() {
    return _isSuccessfulRegister.stream;
  }

}