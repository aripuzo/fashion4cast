import 'dart:async';
import 'dart:io';

import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:meta/meta.dart';

class UserRepository {

  var _isSuccessfulRegister = StreamController<Map<String, String>>.broadcast();
  AppPreferences _appPreferences;
  factory UserRepository({@required AppPreferences appPreferences})=> UserRepository._internal(appPreferences);

  UserRepository._internal(this._appPreferences);

  void updateUser(
      {@required String firstName, @required String lastName,
        @required String userEmail}) {
    Api.initialize().updateUser(firstName: firstName, lastName: lastName,
    userEmail: userEmail).then((result) {
      if (result != null && result.data != null) {
        var user = result.data;
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
          }
        }
        if(result != null && (message == null || message.isEmpty)) {
          if(message == null) message = Map();
          message["message"] = result.message;
        }
        else if(message == null) {
          message = Map();
          message["message"] = AppStrings.EDIT_PROFILE_UNSUCCESSFUL_MSG;
        }
        _isSuccessfulRegister.add(message);
      }
    });
  }

  void updateImage(
      {@required File file}) {
    Api.initialize().updateImage(file: file).then((result) {
      if (result != null && result.data != null) {
        var user = _appPreferences.getUser();
        user.avatar = result.data;
        _appPreferences.setUser(user: user);
        _isSuccessfulRegister.add(null);
      } else {
        Map<String, String> message;
        if(result != null && (message == null || message.isEmpty)) {
          if(message == null) message = Map();
          message["message"] = result.message;
        }
        else if(message == null) {
          message = Map();
          message["message"] = AppStrings.EDIT_PROFILE_UNSUCCESSFUL_MSG;
        }
        _isSuccessfulRegister.add(message);
      }
    });
  }

  void changePassword(
      {@required String currentPassword, @required String password,
        @required String confirmPassword}) {
    Api.initialize().changePassword(currentPassword: currentPassword, password: password,
        confirmPassword: confirmPassword).then((result) {
      if (result != null && result.data != null) {
        var user = result.data;
        _appPreferences.setUser(user: user);
        _isSuccessfulRegister.add(null);
      } else {
        Map<String, String> message;
        if(result != null) {
          var errors = result.errors;
          if (errors != null) {
            message = Map();
            if (errors.currentPassword != null && errors.currentPassword.isNotEmpty)
              message['current_password'] = errors.currentPassword[0];
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
          message["message"] = AppStrings.CHANGE_PASSWORD_UNSUCCESSFUL_MSG;
        }
        _isSuccessfulRegister.add(message);
      }
    });
  }

  void addDevice(
      {@required String deviceId}) {
    Api.initialize().addDevice(deviceId: deviceId).then((result) {
      _appPreferences.setHasDevice(hasDevice: (result != null && result.message.toLowerCase() == "successful"));
    });
  }

  Stream<Map<String, String>> getRegisterResponse() {
    return _isSuccessfulRegister.stream;
  }

}