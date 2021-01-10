import 'package:fashion4cast/form_observers/register_form_observers.dart';

/// App Strings Class -> Resource class for storing app level strings constants
class AppStrings{

  static const String APP_NAME = "Merge";


  //--------------------------------------------------- Login -----------------------------------------------------------------------------------------

  static const String LOGIN_USER_NAME_LABEL = "Email address";
  static const String LOGIN_USER_PASSWORD_LABEL = "Password";

  static const String LOGIN_USER_NAME_HINT = "Enter your email";
  static const String LOGIN_USER_PASSWORD_HINT = "Enter password";

  static const String LOGIN_USER_NAME_ERROR_MSG = "Email must be at least 3 characters";
  static const String LOGIN_USER_PASSWORD_ERROR_MSG = "Password must be at least ${RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH} characters";
  static const String LOGIN_USER_NAME_INVALID_MSG = "Invalid email address";
  static const String LOGIN_USER_PASSWORD_INVALID_MSG = "Invalid user password";

  static const String LOGIN_RESET_BUTTON_LABEL = "Reset";
  static const String LOGIN_LOGIN_BUTTON_LABEL = "Login";

  static const String LOGIN_SUCCESSFUL_LOGIN_MSG = "Successful login";
  static const String LOGIN_UNSUCCESSFUL_LOGIN_MSG = "Invalid credentials";

  static const String LOGIN_TITLE = "Sign in";

  //--------------------------------------------------- Welcome -----------------------------------------------------------------------------------------

  static const String WELCOME_START_BUTTON_LABEL = "Play Game";
  static const String WELCOME_LOGIN_BUTTON_LABEL = "Login";

  static const String WELCOME_VIEW_PROFILE_BUTTON_LABEL = "View Profile";

  //--------------------------------------------------- Register -----------------------------------------------------------------------------------------

  static const String REGISTER_FIRST_NAME_LABEL = "First name";
  static const String REGISTER_LAST_NAME_LABEL = "Last name";
  static const String REGISTER_USER_EMAIL_LABEL = "Email";
  static const String REGISTER_USER_PHONE_LABEL = "Phone number";
  static const String REGISTER_USER_PASSWORD_LABEL = "Password";

  static const String REGISTER_FIRST_NAME_HINT = "Enter first name";
  static const String REGISTER_LAST_NAME_HINT = "Enter last name";
  static const String REGISTER_MIDDLE_NAME_HINT = "Enter middle name";
  static const String REGISTER_USER_EMAIL_HINT = "Enter email";
  static const String REGISTER_USER_PHONE_HINT = "Enter phone number";
  static const String REGISTER_USER_PASSWORD_HINT = "Enter password";
  static const String REGISTER_USER_GENDER_HINT = "Select gender";

  static const String REGISTER_FIRST_NAME_ERROR_MSG = "First name must be at least 3 characters";
  static const String REGISTER_LAST_NAME_ERROR_MSG = "Last name must be at least 3 characters";
  static const String REGISTER_USER_EMAIL_ERROR_MSG = "Invalid email address";
  static const String REGISTER_USER_PHONE_ERROR_MSG = "Invalid phone number";

  //static const String LOGIN_USER_NAME_ERROR_MSG = "User name must be at least 3 characters";
  static const String REGISTER_USER_PASSWORD_ERROR_MSG = "Password must be at least ${RegisterFormObserverContract.USER_PASSWORD_VALID_LENGTH} characters";
  //static const String LOGIN_USER_NAME_INVALID_MSG = "Invalid user name";
  static const String REGISTER_USER_PASSWORD_INVALID_MSG = "Invalid user password";

  static const String REGISTER_LOGIN_BUTTON_LABEL = "Sign up";

  static const String REGISTER_SUCCESSFUL_REGISTER_MSG = "Successful registration";
  static const String REGISTER_UNSUCCESSFUL_REGISTER_MSG = "Unsuccessful registration request";

  static const String EDIT_PROFILE_UNSUCCESSFUL_MSG = "Unsuccessful update request, please try again";

  static const String REGISTER_TITLE = "Sign up";

  static const String REGISTER_ALREADY_REGISTERED = "Already have an account? Log in";

  //--------------------------------------------------- Forgot Password -----------------------------------------------------------------------------------------

  static const String FORGOT_PASSWORD_RESET_BUTTON_LABEL = "Reset";
  static const String FORGOT_PASSWORD_BUTTON_LABEL = "Login";

  static const String FORGOT_PASSWORD_SUCCESSFUL_MSG = "Successful reset request";
  static const String FORGOT_PASSWORD_UNSUCCESSFUL_MSG = "Unsuccessful password reset request";

  //--------------------------------------------------- Change Password -----------------------------------------------------------------------------------------

  static const String CHANGE_PASSWORD_BUTTON_LABEL = "Save Changes";

  static const String CHANGE_PASSWORD_CURRENT_PASSWORD_LABEL = "Current password";
  static const String CHANGE_PASSWORD_NEW_PASSWORD_LABEL = "New password";
  static const String CHANGE_PASSWORD_CONFIRM_PASSWORD_LABEL = "Confirm password";

  static const String CHANGE_PASSWORD_CURRENT_PASSWORD_HINT = "Enter current password";
  static const String CHANGE_PASSWORD_NEW_PASSWORD_HINT = "Enter new password";
  static const String CHANGE_PASSWORD_CONFIRM_PASSWORD_HINT = "Confirm your newpassword";

  static const String CHANGE_PASSWORD_CURRENT_PASSWORD_ERROR_MSG = "Current password not correct";
  static const String CHANGE_PASSWORD_CONFIRM_PASSWORD_ERROR_MSG = "Password does not match";

  static const String CHANGE_PASSWORD_SUCCESSFUL_MSG = "Successful changed password";
  static const String CHANGE_PASSWORD_UNSUCCESSFUL_MSG = "Unsuccessful password change request";

  static const String NETWORK_UNSUCCESSFUL_MSG = "Error connecting to server";

}