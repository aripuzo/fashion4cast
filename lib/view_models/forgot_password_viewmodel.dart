import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/form_observers/forgot_password_form_observers.dart';
import 'package:fashion4cast/repository/forgot_password_repository.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel{

  ForgotPasswordFormObserver _forgotPasswordFormObserver;
  ForgotPasswordRepository _forgotPasswordRepository;

  static ForgotPasswordViewModel _instance;

  final userEmailController = TextEditingController();

  var _forgotPasswordResponseController = StreamController<String>.broadcast();

  factory ForgotPasswordViewModel(App app){
    _instance
    ??= // NULL Check
    ForgotPasswordViewModel._internal(forgotPasswordFormObserver: ForgotPasswordFormObserver(), forgotPasswordRepository: app.getForgotPasswordRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ForgotPasswordViewModel._internal({@required ForgotPasswordFormObserver forgotPasswordFormObserver, @required ForgotPasswordRepository forgotPasswordRepository}){

    _forgotPasswordFormObserver = forgotPasswordFormObserver;

    _forgotPasswordRepository = forgotPasswordRepository;

    _init();

  }

  void _init() {

    userEmailController.addListener(() =>
    getForgotPasswordFormObserver()
        .userEmail
        .add(userEmailController.text));

    _listenLoginResponse();
  }

  void _listenLoginResponse(){
    _forgotPasswordRepository.getLoginResponse()
        .listen(
            (message){
              _forgotPasswordResponseController.add(message);

          if(message == null){
            _forgotPasswordFormObserver.dispose();
          } else {
            _forgotPasswordFormObserver.invalidCredentials();
          }
        }
    );
  }

  ForgotPasswordFormObserver getForgotPasswordFormObserver() => _forgotPasswordFormObserver;

  void forgotPassword({@required String email}) {
    _forgotPasswordRepository.forgotPassword(email: email);
  }

  Stream<String> getForgotPasswordResponse() => _forgotPasswordResponseController.stream;

}