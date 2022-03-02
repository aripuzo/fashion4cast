import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';

import 'register_form_observers.dart';

abstract class LoginFormObserverContract {

  //------------------------------------------------------------ Static Constants ------------------------------------------------------------------
  static const int USER_NAME_VALID_LENGTH = 2;

  Sink get userName;
  Sink get userPassword;

  Stream<bool> get _isValidUserName;
  Stream<bool> get _isValidUserPassword;
  Stream<bool> get isLoginEnabled;
  Stream<String> get userNameErrorText;
  Stream<String> get userPasswordErrorText;

  LoginFormObserverContract(){
    _init();
  }

  void dispose();
  void invalidCredentials();


  void _init(){
    _handleLoginEnableProcess();
  }
  void _handleLoginEnableProcess();

  //Validation Methods
  bool _checkValidUserName(String userName);
  bool _checkValidUserPassword(String userPassword);

}

/// Login Form Observer Class - Observer class implementing LoginFormObserverContract
class LoginFormObserver extends LoginFormObserverContract{

  //------------------------------------------------------------ Observer variables -----------------------------------------------------------------

  // STREAM CONTROLLERS
  var _userNameController = StreamController<String>.broadcast();
  var _userPasswordController = StreamController<String>.broadcast();
  var _userNameErrorMsgController = StreamController<String>.broadcast();
  var _userPasswordErrorMsgController = StreamController<String>.broadcast();
  var _isLoginValidToggleController = StreamController<bool>.broadcast();

  // bool variable to temporarily store result of username and password validation
  bool _tempValidUserName, _tempValidUserPassword;

  //------------------------------------------------------------- Constructor -----------------------------------------------------------------------

  LoginFormObserver():super();

  //------------------------------------------------------------- Contract Observer Methods ---------------------------------------------------------
  @override
  void _init() {
    // Make call to super class _init() method
    super._init();
    // Initially invalidate temporary user name and password
    _tempValidUserName = _tempValidUserPassword = false;
  }

  @override
  void _handleLoginEnableProcess() {

    // Listen to _isValidUserName stream
    _isValidUserName.listen(
            (isValidUserName){
          if(isValidUserName){ // Valid user name
            // Set temporary valid user name to TRUE i.e. set it valid
            _tempValidUserName = true;
            // Now check whether temporary user password is Valid
            _tempValidUserPassword
                ? // Conditional operator
            // VALID
            // Add TRUE event to isLoginValidToggle stream
            _isLoginValidToggleController.add(true)
                :
            // INVALID
            // Do nothing
            null;
            // ADD NULL event to userNameErrorMsg stream
            _userNameErrorMsgController.add(null);
          }else{ // Invalid User Name
            // Set temporary valid user name to FALSE i.e. set it invalid
            _tempValidUserName = false;
            // Add FALSE event to isLoginValidToggle stream
            _isLoginValidToggleController.add(false);
            // ADD user name error string event to userNameErrorMsg stream
            _userNameErrorMsgController.add(AppStrings.LOGIN_USER_NAME_ERROR_MSG);
          }
        });

    // Listen to _isValidUserPassword stream
    _isValidUserPassword.listen(
            (isValidUserPassword){
          if(isValidUserPassword){// Valid user password
            // Set temporary valid user password to TRUE i.e. set it valid
            _tempValidUserPassword = true;
            // Now check whether temporary user name is Valid
            _tempValidUserName
                ? // Conditional operator
            // VALID
            // Add TRUE event to isLoginValidToggle stream
            _isLoginValidToggleController.add(true)
                :
            //INVALID
            // Do nothing
            null;
            // ADD NULL event to userPasswordErrorMsg stream
            _userPasswordErrorMsgController.add(null);
          }else{
            // Set temporary valid user password to FALSE i.e. set it invalid
            _tempValidUserPassword = false;
            // Add FALSE event to isLoginValidToggle stream
            _isLoginValidToggleController.add(false);
            // ADD user password error string event to userPasswordErrorMsg stream
            _userPasswordErrorMsgController.add(AppStrings.LOGIN_USER_PASSWORD_ERROR_MSG);
          }

        });
  }

  //----------------------------------------------------------- Contract Variables ----------------------------------------------------------------
  @override
  // Read the stream from userNameController and map it to bool with _checkValidUserName() method by skipping first n elements of stream
  // where n = User name valid length
  Stream<bool> get _isValidUserName => _userNameController.stream.skip(LoginFormObserverContract.USER_NAME_VALID_LENGTH).map(_checkValidUserName);

  @override
  // Read the stream from userPasswordController and map it to bool with _checkValidUserPassword() method by skipping first n elements of stream
  // where n = User password valid length
  Stream<bool> get _isValidUserPassword => _userPasswordController.stream.skip(RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH).map(_checkValidUserPassword);

  @override
  // Read stream from _isLoginValidToggleController
  Stream<bool> get isLoginEnabled =>  _isLoginValidToggleController.stream;

  @override
  // Write userName sink to _userNameController
  Sink get userName => _userNameController;

  @override
  // Read userNameErrorText stream from _userNameErrorMsgController
  Stream<String> get userNameErrorText => _userNameErrorMsgController.stream;

  @override
  // Write userPassword sink to _userPasswordController
  Sink get userPassword => _userPasswordController;

  @override
  // Read userPasswordErrorText stream from _userPasswordErrorMsgController
  Stream<String> get userPasswordErrorText => _userPasswordErrorMsgController.stream;


  //------------------------------------------------------- Contract Validation Methods --------------------------------------------------------------

  @override
  bool _checkValidUserName(String userEmail){
    return EmailValidator.validate(userEmail);//RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userEmail);
  }

  @override
  bool _checkValidUserPassword(String userPassword)=> userPassword != null && userPassword.length >= RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH;


  //--------------------------------------------------------- Contract Receiver Methods --------------------------------------------------------------

  @override
  void invalidCredentials() {
    // ADD user name invalid string event to userNameErrorMsg stream
    _userNameErrorMsgController.add(AppStrings.LOGIN_USER_NAME_INVALID_MSG);
    // ADD user password invalid string event to userPasswordErrorMsg stream
    _userPasswordErrorMsgController.add(AppStrings.LOGIN_USER_PASSWORD_INVALID_MSG);
  }

  @override
  void dispose() {
    // Close all stream controllers so that there listener could stop listening

    _userNameController.close();
    _userPasswordController.close();
    _userNameErrorMsgController.close();
    _userPasswordErrorMsgController.close();
    _isLoginValidToggleController.close();
  }

}