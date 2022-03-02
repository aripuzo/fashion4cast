import 'dart:async';
import 'dart:io';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/form_observers/edit_profile_form_observers.dart';
import 'package:fashion4cast/models/user.dart';
import 'package:fashion4cast/repository/user_repository.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:flutter/material.dart';

class EditProfileViewModel{

  EditProfileFormObserver _editProfileFormObserver;

  UserRepository _userRepository;

  static EditProfileViewModel _instance;

  // TextEditingController for userName
  final firstNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final lastNameController = TextEditingController();
  // STREAM CONTROLLER for broadcasting login response
  var _registerResponseController = StreamController<String>.broadcast();

  var countryCode = "NG";

  User user;

  factory EditProfileViewModel(App app){
    _instance
    ??= // NULL Check
    EditProfileViewModel._internal(registerFormObserver: EditProfileFormObserver(), registerRepository: app.getUserRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  EditProfileViewModel._internal({@required EditProfileFormObserver registerFormObserver, @required UserRepository registerRepository}){
    _editProfileFormObserver = registerFormObserver;
    _userRepository = registerRepository;
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

    userEmailController.addListener(() =>
    getRegisterFormObserver()
        .userEmail
        .add(userEmailController.text));

    user = App().getAppPreferences().getUser();
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    userEmailController.text = user.email;

    _listenRegisterResponse();
  }

  void _listenRegisterResponse(){
    _userRepository.getRegisterResponse()
        .listen((message){
          if(message == null){
            _registerResponseController.add("Profile update successful");
            _editProfileFormObserver.dispose();
          }else{
            if(message.containsKey("message"))
              _registerResponseController.add(message["message"]);
            else
              _registerResponseController.add(AppStrings.EDIT_PROFILE_UNSUCCESSFUL_MSG);
            //_editProfileFormObserver.invalidCredentials(message);
            _editProfileFormObserver.invalidCredentials();
          }
        }
    );
  }

  EditProfileFormObserver getRegisterFormObserver() => _editProfileFormObserver;

  void updateUser({@required String firstName, @required String lastName,
    @required String userEmail}) {
    _userRepository.updateUser(firstName: firstName, lastName: lastName, userEmail: userEmail);
  }

  void updateImage({@required File file}) {
    _userRepository.updateImage(file: file);
  }

  Stream<String> getRegisterResponse() => _registerResponseController.stream;

  void destroy(){
    _instance = null;
  }

}