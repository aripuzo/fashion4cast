import 'dart:async';

import 'package:fashion4cast/resources/values/app_strings.dart';

/// Login Form Observer Abstract Class - A contract class for Login Form Observer
abstract class RegisterFormObserverContract {

  //------------------------------------------------------------ Static Constants ------------------------------------------------------------------
  static const int FIRST_NAME_VALID_LENGTH = 1;
  //static const int LAST_NAME_VALID_LENGTH = 3;
  static const int USER_PASSWORD_VALID_LENGTH = 6;
  static const int USER_PHONE_VALID_LENGTH = 7;

  // ---------------------------------------------------------- Contract Variables ---------------------------------------------------------------

  // SINK variables
  Sink get firstName;
  Sink get lastName;
  Sink get userEmail;
  Sink get userPhone;
  Sink get userPassword;
  Sink get middleName;

  // STREAM variables
  Stream<bool> get _isValidFirstName;
  Stream<bool> get _isValidLastName;
  Stream<bool> get _isValidUserPassword;
  Stream<bool> get _isValidUserEmail;
  Stream<bool> get _isValidUserPhone;
  /// Is Login Enabled Variable -> Stream<bool>
  /// @usage -> Stream of type bool for streaming whether login is enabled or not
  Stream<bool> get isRegisterEnabled;
  /// User Name Error Text Variable -> Stream<String>
  /// @usage -> Stream of type String for streaming user name error
  Stream<String> get firstNameErrorText;
  Stream<String> get lastNameErrorText;
  Stream<String> get userEmailErrorText;
  Stream<String> get userPhoneErrorText;
  Stream<String> get userPasswordErrorText;

  //------------------------------------------------------------- Contract Constructor -------------------------------------------------------------

  /// Login Form Observer Contract Constructor -> LoginFormObserverContract
  /// @param -> _
  /// @usage -> Initialize init and handleLoginEnableProcess methods for subclass
  RegisterFormObserverContract(){
    _init();
  }

  //-------------------------------------------------------- Contract Methods -------------------------------------------------------------------------

  //Receiver Methods
  /// Dispose Method -> void
  /// @param -> _
  /// @usage -> Dispose the state of LoginFormObserver
  void dispose();
  /// Invalid Credentials Method -> void
  /// @param -> _
  /// @usage -> Initiate process for invalid credentials
  void invalidCredentials(Map<String, String> map);


  //Observer Methods
  /// Init Method -> void
  /// @param -> _
  /// @usage -> Initiate all listeners of observers
  void _init(){
    _handleLoginEnableProcess();
  }
  /// Handle Login Enable Process Method -> void
  /// @param -> _
  /// @usage -> Handle process of enabling login
  void _handleLoginEnableProcess();
  /// Check Valid User Name Method -> bool
  /// @param -> username -> String
  /// @usage -> Validating user name

  //Validation Methods
  bool _checkValidFirstName(String firstName);
  bool _checkValidLastName(String lastName);
  bool _checkValidUserEmail(String userEmail);
  bool _checkValidUserPhone(String userPhone);
  bool _checkValidUserPassword(String userPassword);

}

/// Login Form Observer Class - Observer class implementing LoginFormObserverContract
class RegisterFormObserver extends RegisterFormObserverContract{

  //------------------------------------------------------------ Observer variables -----------------------------------------------------------------

  // STREAM CONTROLLERS
  /// User Name StreamController -> String
  /// @usage -> Control stream of user name by adding sink from 'userName sink' and providing stream of user name
  var _firstNameController = StreamController<String>.broadcast();
  var _lastNameController = StreamController<String>.broadcast();
  var _userEmailController = StreamController<String>.broadcast();
  var _userPhoneController = StreamController<String>.broadcast();
  var _userPasswordController = StreamController<String>.broadcast();
  var _middleNameController = StreamController<String>.broadcast();
  /// User Name Error Message StreamController -> String
  /// @usage -> Control stream of user name error msg
  var _firstNameErrorMsgController = StreamController<String>.broadcast();
  var _lastNameErrorMsgController = StreamController<String>.broadcast();
  var _userEmailErrorMsgController = StreamController<String>.broadcast();
  var _userPhoneErrorMsgController = StreamController<String>.broadcast();
  var _userPasswordErrorMsgController = StreamController<String>.broadcast();
  var _middleNameErrorController = StreamController<String>.broadcast();
  /// Is Login Valid Toggle StreamController -> bool
  /// @usage -> Control stream of valid login toggle
  var _isLoginValidToggleController = StreamController<bool>.broadcast();

  // bool variable to temporarily store result of username and password validation
  bool _tempValidFirstName, _tempValidLastName, _tempValidUserEmail, _tempValidUserPhone, _tempValidUserPassword;

  //------------------------------------------------------------- Constructor -----------------------------------------------------------------------

  RegisterFormObserver():super();

  //------------------------------------------------------------- Contract Observer Methods ---------------------------------------------------------
  @override
  void _init() {
    // Make call to super class _init() method
    super._init();
    // Initially invalidate temporary user name and password
    _tempValidFirstName = _tempValidLastName = _tempValidUserEmail = _tempValidUserPhone = _tempValidUserPassword = false;
  }

  @override
  void _handleLoginEnableProcess() {

    _isValidFirstName.listen(
            (isValidFirstName){
          if(isValidFirstName){
            _tempValidFirstName = true;
            (_tempValidUserPassword && _tempValidUserPhone &&
                _tempValidLastName && _tempValidUserEmail)
                ? _isLoginValidToggleController.add(true)
                :null;
            _firstNameErrorMsgController.add(null);
          }else{ // Invalid User Name
            // Set temporary valid user name to FALSE i.e. set it invalid
            _tempValidFirstName = false;
            // Add FALSE event to isLoginValidToggle stream
            _isLoginValidToggleController.add(false);
            // ADD user name error string event to userNameErrorMsg stream
            _firstNameErrorMsgController.add(AppStrings.REGISTER_FIRST_NAME_ERROR_MSG);
          }
        });

    _isValidLastName.listen(
            (isValidLastName){
          if(isValidLastName){
            _tempValidLastName = true;
            (_tempValidUserPassword && _tempValidUserPhone &&
                _tempValidFirstName && _tempValidUserEmail)
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
            (_tempValidUserPassword && _tempValidUserPhone &&
                _tempValidLastName && _tempValidFirstName)
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

    _isValidUserPhone.listen(
            (isValidUserPhone){
          if(isValidUserPhone){
            _tempValidUserPhone = true;
            (_tempValidUserPassword && _tempValidFirstName &&
                _tempValidLastName && _tempValidUserEmail)
                ? // Conditional operator
            _isLoginValidToggleController.add(true)
                :null;
            _userPhoneErrorMsgController.add(null);
          }else{
            _tempValidUserPhone = false;
            _isLoginValidToggleController.add(false);
            _userPhoneErrorMsgController.add(AppStrings.REGISTER_USER_PHONE_ERROR_MSG);
          }
        });

    // Listen to _isValidUserPassword stream
    _isValidUserPassword.listen(
            (isValidUserPassword){
          if(isValidUserPassword){// Valid user password
            // Set temporary valid user password to TRUE i.e. set it valid
            _tempValidUserPassword = true;
            // Now check whether temporary user name is Valid
            (_tempValidLastName && _tempValidFirstName &&
                _tempValidLastName && _tempValidUserEmail)
                ? _isLoginValidToggleController.add(true): null;
            _userPasswordErrorMsgController.add(null);
          }else{
            _tempValidUserPassword = false;
            _isLoginValidToggleController.add(false);
            _userPasswordErrorMsgController.add(AppStrings.LOGIN_USER_PASSWORD_ERROR_MSG);
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
  Stream<bool> get _isValidUserPhone => _userPhoneController.stream.skip(RegisterFormObserverContract.USER_PHONE_VALID_LENGTH).map(_checkValidUserPhone);

  @override
  // Read the stream from userPasswordController and map it to bool with _checkValidUserPassword() method by skipping first n elements of stream
  // where n = User password valid length
  Stream<bool> get _isValidUserPassword => _userPasswordController.stream.skip(RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH).map(_checkValidUserPassword);

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
  Sink get userPhone => _userPhoneController;

  @override
  Sink get userPassword => _userPasswordController;

  @override
  Sink get middleName => _middleNameController;

  @override
  // Read userNameErrorText stream from _userNameErrorMsgController
  Stream<String> get firstNameErrorText => _firstNameErrorMsgController.stream;

  @override
  Stream<String> get lastNameErrorText => _lastNameErrorMsgController.stream;

  @override
  Stream<String> get userEmailErrorText => _userEmailErrorMsgController.stream;

  @override
  Stream<String> get userPhoneErrorText => _userPhoneErrorMsgController.stream;

  @override
  Stream<String> get userPasswordErrorText => _userPasswordErrorMsgController.stream;


  //------------------------------------------------------- Contract Validation Methods --------------------------------------------------------------

  @override
  // Valid user name string if it is not NULL and its length is greater than defined valid user name length
  bool _checkValidFirstName(String firstName) => firstName != null && firstName.length >= RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH;

  @override
  // Valid user name string if it is not NULL and its length is greater than defined valid user name length
  bool _checkValidLastName(String lastName) => lastName != null && lastName.length >= RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH;

  @override
  // Valid user name string if it is not NULL and its length is greater than defined valid user name length
  bool _checkValidUserPhone(String userPhone) => userPhone != null && userPhone.length > RegisterFormObserverContract.USER_PHONE_VALID_LENGTH;

  @override
  // Valid user name string if it is not NULL and its length is greater than defined valid user name length
  bool _checkValidUserEmail(String userEmail){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userEmail);
  }

  @override
  // Valid user password string if it is not NULL and its length is greater than defined valid user password length
  bool _checkValidUserPassword(String userPassword)=> userPassword != null && userPassword.length >= RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH;


  //--------------------------------------------------------- Contract Receiver Methods --------------------------------------------------------------

  @override
  void invalidCredentials(Map<String, String> map) {
    if(map != null) {
      if (map.containsKey("email"))
        _userEmailErrorMsgController.add(map['email']);
      if (map.containsKey("phone"))
        _userPhoneErrorMsgController.add(map['phone']);
      if (map.containsKey("password"))
        _userPasswordErrorMsgController.add(map['password']);
    }
    else
      _userPasswordErrorMsgController.add(AppStrings.REGISTER_USER_PASSWORD_INVALID_MSG);
  }

  @override
  void dispose() {
    // Close all stream controllers so that there listener could stop listening

    _firstNameController.close();
    _lastNameController.close();
    _userPhoneController.close();
    _userEmailController.close();
    _userPasswordController.close();
    _middleNameController.close();

    _firstNameErrorMsgController.close();
    _lastNameErrorMsgController.close();
    _userEmailErrorMsgController.close();
    _userPhoneErrorMsgController.close();
    _userPasswordErrorMsgController.close();
    _isLoginValidToggleController.close();
    _middleNameErrorController.close();
  }

  @override
  Stream<bool> get _isValidUserEmail =>_userEmailController.stream.skip(RegisterFormObserverContract.FIRST_NAME_VALID_LENGTH).map(_checkValidUserEmail);

}