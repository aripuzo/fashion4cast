import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/form_observers/change_password_form_observers.dart';
import 'package:fashion4cast/repository/user_repository.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:flutter/material.dart';

class ChangePasswordViewModel{

  ChangePasswordFormObserver _changePasswordFormObserver;
  UserRepository _userRepository;

  static ChangePasswordViewModel _instance;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var _loginResponseController = StreamController<String>.broadcast();

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  /// LoginViewModel Factory Constructor -> LoginViewModel
  /// @dependency -> App
  /// @usage -> Returns LoginViewModel Singleton-Instance by injecting dependency for private constructor.
  factory ChangePasswordViewModel(App app){
    _instance
    ??= // NULL Check
    ChangePasswordViewModel._internal(loginFormObserver: ChangePasswordFormObserver(), loginRepository: app.getUserRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  /// LoginViewModel Private Constructor -> LoginViewModel
  /// @param -> @required loginFormObserver -> LoginFormObserver
  ///        -> @required loginRepository -> LoginRepository
  /// @usage -> Initialize private variables and invoke _init() method
  ChangePasswordViewModel._internal({@required ChangePasswordFormObserver loginFormObserver, @required UserRepository loginRepository}){

    _changePasswordFormObserver = loginFormObserver;

    _userRepository = loginRepository;

    _init();

  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {

    oldPasswordController.addListener(() =>
    getChangePasswordFormObserver()
        .oldPassword
        .add(oldPasswordController.text));

    newPasswordController.addListener(() =>
    getChangePasswordFormObserver()
        .newPassword
        .add(newPasswordController.text));

    confirmPasswordController.addListener(() =>
        getChangePasswordFormObserver()
            .confirmPassword
            .add(confirmPasswordController.text));

    _listenLoginResponse();
  }

  void _listenLoginResponse(){
    _userRepository.getRegisterResponse()
        .listen((message){
          if(message == null){
            _changePasswordFormObserver.dispose();
            _loginResponseController.add(AppStrings.CHANGE_PASSWORD_SUCCESSFUL_MSG);
          }else{
            if(message.containsKey("message"))
              _loginResponseController.add(message["message"]);
            else
              _loginResponseController.add(AppStrings.CHANGE_PASSWORD_UNSUCCESSFUL_MSG);
            _changePasswordFormObserver.invalidCredentials(message);
          }
        }
    );
  }

  ChangePasswordFormObserver getChangePasswordFormObserver() => _changePasswordFormObserver;

  void changePassword({@required String oldPassword, @required String password, @required String confirmPassword}) {
    _userRepository.changePassword(currentPassword: oldPassword, password: password, confirmPassword: confirmPassword);
  }

  Stream<String> getLoginResponse() => _loginResponseController.stream;

}