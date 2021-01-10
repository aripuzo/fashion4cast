import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/form_observers/reset_password_form_observers.dart';
import 'package:fashion4cast/repository/reset_password_repository.dart';
import 'package:flutter/material.dart';

class ResetPasswordViewModel{

  ResetPasswordFormObserver _resetPasswordFormObserver;
  ResetPasswordRepository _resetPasswordRepository;

  static ResetPasswordViewModel _instance;

  //final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userTokenController = TextEditingController();

  var _forgotPasswordResponseController = StreamController<String>.broadcast();

  factory ResetPasswordViewModel(App app){
    _instance
    ??= // NULL Check
    ResetPasswordViewModel._internal(forgotPasswordFormObserver: ResetPasswordFormObserver(), forgotPasswordRepository: app.getResetPasswordRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ResetPasswordViewModel._internal({@required ResetPasswordFormObserver forgotPasswordFormObserver, @required ResetPasswordRepository forgotPasswordRepository}){

    _resetPasswordFormObserver = forgotPasswordFormObserver;

    _resetPasswordRepository = forgotPasswordRepository;

    _init();

  }

  void _init() {

//    userEmailController.addListener(() =>
//        getResetPasswordFormObserver()
//        .userName
//        .add(userEmailController.text));

    userTokenController.addListener(() =>
        getResetPasswordFormObserver()
            .userToken
            .add(userTokenController.text));

    userPasswordController.addListener(() =>
        getResetPasswordFormObserver()
            .userPassword
            .add(userPasswordController.text));

    _listenLoginResponse();
  }

  void _listenLoginResponse(){
    _resetPasswordRepository.getLoginResponse()
        .listen(
            (message){
              _forgotPasswordResponseController.add(message);

          if(message == null){
            _resetPasswordFormObserver.dispose();
          } else {
            _resetPasswordFormObserver.invalidCredentials();
          }
        }
    );
  }

  ResetPasswordFormObserver getResetPasswordFormObserver() => _resetPasswordFormObserver;

  void resetPassword({@required String email, @required String password,
    @required String token}) {
    _resetPasswordRepository.resetPassword(email: email, password: password, token: token);
  }

  Stream<String> getResetPasswordResponse() => _forgotPasswordResponseController.stream;

}