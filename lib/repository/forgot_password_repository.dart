import 'dart:async';

import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:meta/meta.dart';

class ForgotPasswordRepository {

  var _isSuccessfulLogin = StreamController<String>.broadcast();
  AppPreferences _appPreferences;
  factory ForgotPasswordRepository({@required AppPreferences appPreferences})=> ForgotPasswordRepository._internal(appPreferences);

  ForgotPasswordRepository._internal(this._appPreferences);

  void forgotPassword(
      {@required String email}) {
    Api.initialize().forgotPassword(email: email).then((result) {
      if (result != null) {
        _isSuccessfulLogin.add(null);
      } else {
        String message = (result != null && result.messages != null)
            ? result.messages : AppStrings.FORGOT_PASSWORD_UNSUCCESSFUL_MSG;
        _isSuccessfulLogin.add(message);
      }
    });
  }

  Stream<String> getLoginResponse() {
    return _isSuccessfulLogin.stream;
  }

}