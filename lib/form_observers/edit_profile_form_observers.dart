import 'dart:async';

import 'package:fashion4cast/resources/values/app_strings.dart';

import 'register_form_observers.dart';

abstract class EditProfileFormObserverContract {

  // SINK variables
  Sink get firstName;
  Sink get lastName;
  Sink get userEmail;

  // STREAM variables
  Stream<bool> get _isValidFirstName;
  Stream<bool> get _isValidLastName;
  Stream<bool> get _isValidUserEmail;

  Stream<bool> get isRegisterEnabled;

  Stream<String> get firstNameErrorText;
  Stream<String> get lastNameErrorText;
  Stream<String> get userEmailErrorText;

  //------------------------------------------------------------- Contract Constructor -------------------------------------------------------------

  EditProfileFormObserverContract(){
    _init();
  }

  //-------------------------------------------------------- Contract Methods -------------------------------------------------------------------------

  //Receiver Methods
  void dispose();

  void invalidCredentials();


  //Observer Methods
  void _init(){
    _handleLoginEnableProcess();
  }
  void _handleLoginEnableProcess();

  //Validation Methods
  bool _checkValidFirstName(String firstName);
  bool _checkValidLastName(String lastName);
  bool _checkValidUserEmail(String userEmail);

}

class EditProfileFormObserver extends EditProfileFormObserverContract{

  //------------------------------------------------------------ Observer variables -----------------------------------------------------------------

  // STREAM CONTROLLERS
  var _firstNameController = StreamController<String>.broadcast();
  var _lastNameController = StreamController<String>.broadcast();
  var _userEmailController = StreamController<String>.broadcast();

  var _firstNameErrorMsgController = StreamController<String>.broadcast();
  var _lastNameErrorMsgController = StreamController<String>.broadcast();
  var _userEmailErrorMsgController = StreamController<String>.broadcast();

  var _isLoginValidToggleController = StreamController<bool>.broadcast();

  // bool variable to temporarily store result of username and password validation
  bool _tempValidFirstName, _tempValidLastName, _tempValidUserEmail;

  //------------------------------------------------------------- Constructor -----------------------------------------------------------------------

  EditProfileFormObserver():super();

  //------------------------------------------------------------- Contract Observer Methods ---------------------------------------------------------
  @override
  void _init() {
    super._init();
    _tempValidFirstName = _tempValidLastName = _tempValidUserEmail = false;
  }

  @override
  void _handleLoginEnableProcess() {

    _isValidFirstName.listen(
            (isValidFirstName){
          if(isValidFirstName){
            _tempValidFirstName = true;
            (_tempValidLastName && _tempValidUserEmail)
                ? _isLoginValidToggleController.add(true)
                :null;
            _firstNameErrorMsgController.add(null);
          }else{
            _tempValidFirstName = false;
            _isLoginValidToggleController.add(false);
            _firstNameErrorMsgController.add(AppStrings.REGISTER_FIRST_NAME_ERROR_MSG);
          }
        });

    _isValidLastName.listen(
            (isValidLastName){
          if(isValidLastName){
            _tempValidLastName = true;
            (_tempValidFirstName && _tempValidUserEmail)
                ? _isLoginValidToggleController.add(true)
                :null;
            _lastNameErrorMsgController.add(null);
          }else{
            _tempValidLastName = false;
            _isLoginValidToggleController.add(false);
            _lastNameErrorMsgController.add(AppStrings.REGISTER_LAST_NAME_ERROR_MSG);
          }
        });

    _isValidUserEmail.listen(
            (isValidUserEmail){
          if(isValidUserEmail){
            _tempValidUserEmail = true;
            (_tempValidLastName && _tempValidFirstName)
                ? // Conditional operator
            _isLoginValidToggleController.add(true)
                :
            null;
            _userEmailErrorMsgController.add(null);
          }else{
            _tempValidUserEmail = false;
            _isLoginValidToggleController.add(false);
            _userEmailErrorMsgController.add(AppStrings.REGISTER_USER_EMAIL_ERROR_MSG);
          }
        });
  }

  //----------------------------------------------------------- Contract Variables ----------------------------------------------------------------
  @override
  // Read the stream from userNameController and map it to bool with _checkValidUserName() method by skipping first n elements of stream
  // where n = User name valid length
  Stream<bool> get _isValidFirstName => _firstNameController.stream.skip(RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH).map(_checkValidFirstName);

  @override
  Stream<bool> get _isValidLastName => _lastNameController.stream.skip(RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH).map(_checkValidLastName);

  @override
  // Read stream from _isLoginValidToggleController
  Stream<bool> get isRegisterEnabled =>  _isLoginValidToggleController.stream;

  @override
  // Write userName sink to _userNameController
  Sink get firstName => _firstNameController;

  @override
  Sink get lastName => _lastNameController;

  @override
  Sink get userEmail => _userEmailController;

  @override
  Stream<String> get firstNameErrorText => _firstNameErrorMsgController.stream;

  @override
  Stream<String> get lastNameErrorText => _lastNameErrorMsgController.stream;

  @override
  Stream<String> get userEmailErrorText => _userEmailErrorMsgController.stream;


  //------------------------------------------------------- Contract Validation Methods --------------------------------------------------------------

  @override
  bool _checkValidFirstName(String firstName) => firstName != null && firstName.length >= RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH;

  @override
  bool _checkValidLastName(String lastName) => lastName != null && lastName.length >= RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH;

  @override
  bool _checkValidUserEmail(String userEmail){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userEmail);
  }

  //--------------------------------------------------------- Contract Receiver Methods --------------------------------------------------------------

  @override
  void invalidCredentials() {
    // ADD user name invalid string event to userNameErrorMsg stream
    //_firstNameErrorMsgController.add(AppStrings.REGISTER_USER_PASSWORD_INVALID_MSG);
  }

  @override
  void dispose() {
    // Close all stream controllers so that there listener could stop listening

    _firstNameController.close();
    _lastNameController.close();
    _userEmailController.close();

    _firstNameErrorMsgController.close();
    _lastNameErrorMsgController.close();
    _userEmailErrorMsgController.close();
    _isLoginValidToggleController.close();
  }

  @override
  Stream<bool> get _isValidUserEmail =>_userEmailController.stream.skip(RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH).map(_checkValidUserEmail);

}