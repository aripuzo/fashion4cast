import 'dart:async';

import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:meta/meta.dart';

class ResetPasswordRepository {

  var _isSuccessfulLogin = StreamController<String>.broadcast();
  AppPreferences _appPreferences;
  factory ResetPasswordRepository({@required AppPreferences appPreferences})=> ResetPasswordRepository._internal(appPreferences);

  ResetPasswordRepository._internal(this._appPreferences);

  void resetPassword(
      {@required String email, @required String password, @required String token}) {
    Api.initialize().resetPassword(email: email,
        password: password, token: token).then((result) {
      if (result != null) {
        _isSuccessfulLogin.add(null);
      } else {
        String message = (result != null && result.message != null)
            ? result.message : AppStrings.FORGOT_PASSWORD_UNSUCCESSFUL_MSG;
        _isSuccessfulLogin.add(message);
      }
    });
  }

  Stream<String> getLoginResponse() {
    return _isSuccessfulLogin.stream;
  }

}