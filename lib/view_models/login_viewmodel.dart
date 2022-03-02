import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/form_observers/login_form_observers.dart';
import 'package:fashion4cast/repository/login_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel{

  LoginFormObserver _loginFormObserver;
  LoginRepository _loginRepository;

  static LoginViewModel _instance;

  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();

  var _loginResponseController = StreamController<String>.broadcast();

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  /// LoginViewModel Factory Constructor -> LoginViewModel
  /// @dependency -> App
  /// @usage -> Returns LoginViewModel Singleton-Instance by injecting dependency for private constructor.
  factory LoginViewModel(App app){
    _instance
    ??= // NULL Check
    LoginViewModel._internal(loginFormObserver: LoginFormObserver(), loginRepository: app.getLoginRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  /// LoginViewModel Private Constructor -> LoginViewModel
  /// @param -> @required loginFormObserver -> LoginFormObserver
  ///        -> @required loginRepository -> LoginRepository
  /// @usage -> Initialize private variables and invoke _init() method
  LoginViewModel._internal({@required LoginFormObserver loginFormObserver, @required LoginRepository loginRepository}){

    _loginFormObserver = loginFormObserver;

    _loginRepository = loginRepository;

    _init();

  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {

    userNameController.addListener(() =>
    getLoginFormObserver()
        .userName
        .add(userNameController.text));

    userPasswordController.addListener(() =>
    getLoginFormObserver()
        .userPassword
        .add(userPasswordController.text));

    _listenLoginResponse();
  }

  void clear(){
    userNameController.clear();
    userPasswordController.clear();
  }

  void _listenLoginResponse(){
    _loginRepository.getLoginResponse()
        .listen(
            (message){
          _loginResponseController.add(message);
          if(message == null){
            clear();
            _loginFormObserver.dispose();
          } else {
            _loginFormObserver.invalidCredentials();
          }
        }
    );
  }

  LoginFormObserver getLoginFormObserver() => _loginFormObserver;

  void checkLogin({@required String userName, @required String userPassword}) {
    _loginRepository.isAuthenticUser(userName: userName, userPassword: userPassword);
  }

  Stream<String> getLoginResponse() => _loginResponseController.stream;

}