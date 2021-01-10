import 'dart:async';

import 'package:fashion4cast/resources/values/app_strings.dart';

import 'register_form_observers.dart';

abstract class ChangePasswordFormObserverContract {

  //------------------------------------------------------------ Static Constants ------------------------------------------------------------------
  static const int OLD_PASSWORD_VALID_LENGTH = 2;

  Sink get confirmPassword;
  Sink get newPassword;
  Sink get oldPassword;

  Stream<bool> get _isValidNewPassword;
  Stream<bool> get _isValidConfirmPassword;
  Stream<bool> get _isValidOldPassword;
  Stream<bool> get isLoginEnabled;
  Stream<String> get newPasswordErrorText;
  Stream<String> get oldPasswordErrorText;
  Stream<String> get confirmPasswordErrorText;

  ChangePasswordFormObserverContract(){
    _init();
  }

  void dispose();
  void invalidCredentials(Map<String, String> map);


  void _init(){
    _handleLoginEnableProcess();
  }
  void _handleLoginEnableProcess();

  //Validation Methods
  bool _checkValidOldPassword(String userPassword);
  bool _checkValidNewPassword(String userPassword);
  bool _checkValidConfirmPassword(String userPassword);

}

class ChangePasswordFormObserver extends ChangePasswordFormObserverContract{

  //------------------------------------------------------------ Observer variables -----------------------------------------------------------------

  // STREAM CONTROLLERS
  var _newPasswordController = StreamController<String>.broadcast();
  var _oldPasswordController = StreamController<String>.broadcast();
  var _confirmPasswordController = StreamController<String>.broadcast();
  var _newPasswordErrorMsgController = StreamController<String>.broadcast();
  var _oldPasswordErrorMsgController = StreamController<String>.broadcast();
  var _confirmPasswordErrorMsgController = StreamController<String>.broadcast();
  var _isLoginValidToggleController = StreamController<bool>.broadcast();

  // bool variable to temporarily store result of username and password validation
  bool _tempValidNewPassword, _tempValidOldPassword, _tempValidConfirmPassword;

  String password;

  //------------------------------------------------------------- Constructor -----------------------------------------------------------------------

  ChangePasswordFormObserver():super();

  //------------------------------------------------------------- Contract Observer Methods ---------------------------------------------------------
  @override
  void _init() {
    super._init();
    _tempValidNewPassword = _tempValidConfirmPassword = _tempValidOldPassword = false;
  }

  @override
  void _handleLoginEnableProcess() {

    _isValidNewPassword.listen(
            (isValidNewPassword){
          if(isValidNewPassword){
            _tempValidNewPassword = true;
            (_tempValidConfirmPassword && _tempValidOldPassword)
                ?
            _isLoginValidToggleController.add(true)
                :
            null;
            _newPasswordErrorMsgController.add(null);
          }else{
            _tempValidNewPassword = false;
            _tempValidConfirmPassword = false;
            _isLoginValidToggleController.add(false);
            _newPasswordErrorMsgController.add(AppStrings.REGISTER_USER_PASSWORD_ERROR_MSG);
          }
        });

    _isValidConfirmPassword.listen(
            (isValidConfirmPassword){
          if(isValidConfirmPassword){
            _tempValidConfirmPassword = true;
            (_tempValidNewPassword && _tempValidOldPassword)
                ?
            _isLoginValidToggleController.add(true)
                :
            null;
            _confirmPasswordErrorMsgController.add(null);
          }else{
            _tempValidConfirmPassword = false;
            _isLoginValidToggleController.add(false);
            _confirmPasswordErrorMsgController.add(AppStrings.CHANGE_PASSWORD_CONFIRM_PASSWORD_ERROR_MSG);
          }

        });

    _isValidOldPassword.listen(
            (isValidOldPassword){
          if(isValidOldPassword){
            _tempValidOldPassword = true;
            (_tempValidNewPassword && _tempValidConfirmPassword)
                ?
            _isLoginValidToggleController.add(true)
                :
            null;
            _oldPasswordErrorMsgController.add(null);
          }else{
            _tempValidOldPassword = false;
            _isLoginValidToggleController.add(false);
            _oldPasswordErrorMsgController.add(AppStrings.CHANGE_PASSWORD_CURRENT_PASSWORD_ERROR_MSG);
          }

        });
  }

  //----------------------------------------------------------- Contract Variables ----------------------------------------------------------------
  @override
  Stream<bool> get _isValidNewPassword => _newPasswordController.stream.skip(RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH).map(_checkValidNewPassword);

  @override
  Stream<bool> get _isValidConfirmPassword => _confirmPasswordController.stream.skip(RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH).map(_checkValidConfirmPassword);

  @override
  Stream<bool> get _isValidOldPassword => _oldPasswordController.stream.skip(ChangePasswordFormObserverContract.OLD_PASSWORD_VALID_LENGTH).map(_checkValidOldPassword);

  @override
  Stream<bool> get isLoginEnabled =>  _isLoginValidToggleController.stream;

  @override
  Sink get confirmPassword => _confirmPasswordController;

  @override
  Stream<String> get confirmPasswordErrorText => _confirmPasswordErrorMsgController.stream;

  @override
  Sink get newPassword => _newPasswordController;

  @override
  Stream<String> get newPasswordErrorText => _newPasswordErrorMsgController.stream;

  @override
  Sink get oldPassword => _oldPasswordController;

  @override
  Stream<String> get oldPasswordErrorText => _oldPasswordErrorMsgController.stream;


  //------------------------------------------------------- Contract Validation Methods --------------------------------------------------------------

  @override
  bool _checkValidConfirmPassword(String userPassword){
    return userPassword == password;
  }

  @override
  bool _checkValidNewPassword(String userPassword) {
    password = userPassword;
    return userPassword != null && userPassword.length >=
        RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH;
  }

  @override
  bool _checkValidOldPassword(String userPassword) => userPassword != null && userPassword.length >= ChangePasswordFormObserverContract.OLD_PASSWORD_VALID_LENGTH;



  //--------------------------------------------------------- Contract Receiver Methods --------------------------------------------------------------

  @override
  void invalidCredentials(Map<String, String> map) {
    if(map != null) {
      if (map.containsKey("current_password"))
        _oldPasswordErrorMsgController.add(map['current_password']);
      if (map.containsKey("password"))
        _newPasswordErrorMsgController.add(map['password']);
    }
  }

    @override
    void dispose() {
      // Close all stream controllers so that there listener could stop listening

      _newPasswordController.close();
      _newPasswordErrorMsgController.close();
      _oldPasswordController.close();
      _oldPasswordErrorMsgController.close();
      _confirmPasswordController.close();
      _confirmPasswordErrorMsgController.close();
      _isLoginValidToggleController.close();
    }

}