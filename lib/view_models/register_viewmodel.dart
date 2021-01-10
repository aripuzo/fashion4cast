import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/form_observers/register_form_observers.dart';
import 'package:fashion4cast/repository/register_repository.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:flutter/material.dart';

class RegisterViewModel{

  RegisterFormObserver _registerFormObserver;

  RegisterRepository _registerRepository;

  static RegisterViewModel _instance;

  // TextEditingController for userName
  final firstNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final lastNameController = TextEditingController();
  final userPhoneController = TextEditingController();
  final userPasswordController = TextEditingController();
  // STREAM CONTROLLER for broadcasting login response
  var _registerResponseController = StreamController<String>.broadcast();

  var countryCode = "NG";

  factory RegisterViewModel(App app){
    _instance
    ??= // NULL Check
    RegisterViewModel._internal(registerFormObserver: RegisterFormObserver(), registerRepository: app.getRegisterRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  RegisterViewModel._internal({@required RegisterFormObserver registerFormObserver, @required RegisterRepository registerRepository}){
    _registerFormObserver = registerFormObserver;
    _registerRepository = registerRepository;
    _init();
  }

  void _init() {

    // Add listener to firstNameController
    firstNameController.addListener(() =>
    getRegisterFormObserver()
        .firstName
        .add(firstNameController.text));

    lastNameController.addListener(() =>
        getRegisterFormObserver()
            .lastName
            .add(lastNameController.text));

    userPhoneController.addListener(() =>
    getRegisterFormObserver()
        .userPhone
        .add(userPhoneController.text));

    userEmailController.addListener(() =>
    getRegisterFormObserver()
        .userEmail
        .add(userEmailController.text));

    userPasswordController.addListener(() =>
    getRegisterFormObserver()
        .userPassword
        .add(userPasswordController.text));

    _listenRegisterResponse();
  }

  void clear(){
    firstNameController.clear();
    lastNameController.clear();
    userEmailController.clear();
    userPasswordController.clear();
    userPhoneController.clear();
  }

  void _listenRegisterResponse(){
    _registerRepository.getRegisterResponse()
        .listen((message){
          if(message == null){
            _registerFormObserver.dispose();
            _registerResponseController.add(null);
            clear();
          }else{
            if(message.containsKey("message"))
              _registerResponseController.add(message["message"]);
            else
              _registerResponseController.add(AppStrings.REGISTER_UNSUCCESSFUL_REGISTER_MSG);
            _registerFormObserver.invalidCredentials(message);
          }
        }
    );
  }

  RegisterFormObserver getRegisterFormObserver() => _registerFormObserver;

  void checkRegister({@required String firstName, @required String lastName,
    @required String userEmail,
    @required String userPhone, @required String countryCode,
    @required String userPassword}) {
    _registerRepository.registerUser(firstName: firstName, lastName: lastName,
    countryCode: countryCode, userEmail: userEmail,
    userPhone: userPhone, userPassword: userPassword);
  }

  Stream<String> getRegisterResponse() => _registerResponseController.stream;

}