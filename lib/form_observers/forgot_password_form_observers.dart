import 'dart:async';

import 'package:fashion4cast/resources/values/app_strings.dart';

abstract class ForgotPasswordFormObserverContract {

  static const int USER_NAME_VALID_LENGTH = 3;

  Sink get userEmail;

  Stream<bool> get _isValidUserEmail;
  Stream<bool> get isLoginEnabled;
  Stream<String> get userEmailErrorText;

  ForgotPasswordFormObserverContract(){
    _init();
  }

  void dispose();
  void invalidCredentials();


  void _init(){
    _handleLoginEnableProcess();
  }
  void _handleLoginEnableProcess();

  //Validation Methods
  bool _checkValidUserEmail(String userName);

}

/// Login Form Observer Class - Observer class implementing LoginFormObserverContract
class ForgotPasswordFormObserver extends ForgotPasswordFormObserverContract{

  //------------------------------------------------------------ Observer variables -----------------------------------------------------------------

  // STREAM CONTROLLERS
  var _userEmailController = StreamController<String>.broadcast();
  var _userEmailErrorMsgController = StreamController<String>.broadcast();
  var _isLoginValidToggleController = StreamController<bool>.broadcast();

  // bool variable to temporarily store result of username and password validation
  bool _tempValidUserEmail;

  //------------------------------------------------------------- Constructor -----------------------------------------------------------------------

  ForgotPasswordFormObserver():super();

  //------------------------------------------------------------- Contract Observer Methods ---------------------------------------------------------
  @override
  void _init() {
    // Make call to super class _init() method
    super._init();
    // Initially invalidate temporary user name and password
    _tempValidUserEmail = false;
  }

  @override
  void _handleLoginEnableProcess() {

    _isValidUserEmail.listen(
            (isValidUserName){
          if(isValidUserName){
            _tempValidUserEmail = true;
            _isLoginValidToggleController.add(true);
            _userEmailErrorMsgController.add(null);
          }else{
            _tempValidUserEmail = false;
            _isLoginValidToggleController.add(false);
            _userEmailErrorMsgController.add(AppStrings.LOGIN_USER_NAME_ERROR_MSG);
          }
        });
  }

  //----------------------------------------------------------- Contract Variables ----------------------------------------------------------------
  @override
  Stream<bool> get _isValidUserEmail => _userEmailController.stream.skip(ForgotPasswordFormObserverContract.USER_NAME_VALID_LENGTH).map(_checkValidUserEmail);

  @override
  Stream<bool> get isLoginEnabled =>  _isLoginValidToggleController.stream;

  @override
  Sink get userEmail => _userEmailController;

  @override
  Stream<String> get userEmailErrorText => _userEmailErrorMsgController.stream;

  @override
  bool _checkValidUserEmail(String userEmail){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userEmail);
  }

  @override
  void invalidCredentials() {
    _userEmailErrorMsgController.add(AppStrings.LOGIN_USER_NAME_INVALID_MSG);
  }

  @override
  void dispose() {
    // Close all stream controllers so that there listener could stop listening

    _userEmailController.close();
    _userEmailErrorMsgController.close();
    _isLoginValidToggleController.close();
  }

}