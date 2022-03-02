import 'dart:async';

import 'package:fashion4cast/resources/values/app_strings.dart';

abstract class ResetPasswordFormObserverContract {

  //------------------------------------------------------------ Static Constants ------------------------------------------------------------------
  static const int USER_NAME_VALID_LENGTH = 3;
  static const int USER_PASSWORD_VALID_LENGTH = 6;
  static const int USER_TOKEN_VALID_LENGTH = 6;

  Sink get userPassword;
  Sink get userToken;

  Stream<bool> get _isValidUserPassword;
  Stream<bool> get _isValidUserToken;
  Stream<bool> get isLoginEnabled;
  Stream<String> get userPasswordErrorText;
  Stream<String> get userTokenErrorText;

  ResetPasswordFormObserverContract(){
    _init();
  }

  void dispose();
  void invalidCredentials();


  void _init(){
    _handleLoginEnableProcess();
  }
  void _handleLoginEnableProcess();

  bool _checkValidUserPassword(String userPassword);
  bool _checkValidUserToken(String userToken);

}

class ResetPasswordFormObserver extends ResetPasswordFormObserverContract{

  //------------------------------------------------------------ Observer variables -----------------------------------------------------------------

  // STREAM CONTROLLERS
  var _userPasswordController = StreamController<String>.broadcast();
  var _userTokenController = StreamController<String>.broadcast();
  var _userPasswordErrorMsgController = StreamController<String>.broadcast();
  var _userTokenErrorMsgController = StreamController<String>.broadcast();
  var _isLoginValidToggleController = StreamController<bool>.broadcast();

  bool _tempValidUserPassword, _tempValidUserToken;

  ResetPasswordFormObserver():super();

  @override
  void _init() {
    super._init();
    _tempValidUserPassword = _tempValidUserToken = false;
  }

  @override
  void _handleLoginEnableProcess() {

    _isValidUserPassword.listen(
            (isValidUserPassword){
          if(isValidUserPassword){
            _tempValidUserPassword = true;
            (_tempValidUserToken)
                ?
            _isLoginValidToggleController.add(true)
                :
            null;
            _userPasswordErrorMsgController.add(null);
          }else{
            _tempValidUserPassword = false;
            _isLoginValidToggleController.add(false);
            _userPasswordErrorMsgController.add(AppStrings.LOGIN_USER_PASSWORD_ERROR_MSG);
          }
        });

    _isValidUserToken.listen(
            (isValidUserToken){
          if(isValidUserToken){
            _tempValidUserToken = true;
            (_tempValidUserPassword)
                ?
            _isLoginValidToggleController.add(true)
                :
            null;
            _userTokenErrorMsgController.add(null);
          }else{
            _tempValidUserToken = false;
            _isLoginValidToggleController.add(false);
            _userTokenErrorMsgController.add("Invalid token");
          }
        });
  }

  //----------------------------------------------------------- Contract Variables ----------------------------------------------------------------
  @override
  Stream<bool> get _isValidUserPassword => _userPasswordController.stream.skip(ResetPasswordFormObserverContract.USER_PASSWORD_VALID_LENGTH).map(_checkValidUserPassword);

  @override
  Stream<bool> get _isValidUserToken => _userTokenController.stream.skip(ResetPasswordFormObserverContract.USER_TOKEN_VALID_LENGTH).map(_checkValidUserToken);

  @override
  Stream<bool> get isLoginEnabled =>  _isLoginValidToggleController.stream;

  @override
  Sink get userPassword => _userPasswordController;

  @override
  Stream<String> get userPasswordErrorText => _userPasswordErrorMsgController.stream;

  @override
  Sink get userToken => _userTokenController;

  @override
  Stream<String> get userTokenErrorText => _userTokenErrorMsgController.stream;

  //------------------------------------------------------- Contract Validation Methods --------------------------------------------------------------

  @override
  bool _checkValidUserPassword(String userPassword)=> userPassword != null && userPassword.length >= ResetPasswordFormObserverContract.USER_PASSWORD_VALID_LENGTH;

  @override
  bool _checkValidUserToken(String userToken)=> userToken != null && userToken.length >= ResetPasswordFormObserverContract.USER_TOKEN_VALID_LENGTH;

  //--------------------------------------------------------- Contract Receiver Methods --------------------------------------------------------------

  @override
  void invalidCredentials() {
    _userTokenErrorMsgController.add("Invalid token");
    _userPasswordErrorMsgController.add(AppStrings.LOGIN_USER_PASSWORD_INVALID_MSG);
  }

  @override
  void dispose() {
    _userPasswordController.close();
    _userTokenController.close();
    _userPasswordErrorMsgController.close();
    _userTokenErrorMsgController.close();
    _isLoginValidToggleController.close();
  }

}