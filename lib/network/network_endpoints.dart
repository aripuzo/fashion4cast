class NetworkEndpoints {

  static const String _STAGING_BASE_URL = "https://fashion4cast.ajizzy.net";
  static const String _PRODUCTION_BASE_URL = "https://api.fashion4castapp.com";
  static const String BASE_API = (AppConstants.isDebug ? _STAGING_BASE_URL : _PRODUCTION_BASE_URL) + "/api/v1";

  //Auth
  static const String LOGIN_API = "/auth/login";
  static const String REGISTER_API = "/auth/register";
  static const String FORGOT_PASSWORD_API = "/auth/reset-password";
  static const String RESET_PASSWORD_API = "/auth/reset-password-complete";

  //Account
  static const String ACCOUNT_PROFILE_API = "/account/profile";
  static const String ACCOUNT_NOTIFICATION_API = "/account/profile/notification";
  static const String ACCOUNT_AVATAR_API = "/account/profile/avatar";
  static const String ACCOUNT_DEVICES_API = "/account/devices";
  static const String ACCOUNT_CHANGE_PASSWORD_API = "/account/change-password";

  //Places
  static const String PLACES_API = "/places";
  static const String PLACES_ADD_API = "/places/add";
  static const String PLACES_AUTOCOMPLETE_API = "/places/autocomplete";

  //Weather
  static const String WEATHER_API = "/weather";

  //Products
  static const String PRODUCT_API = "/products";

  //Ads
  static const String AD_API = "/ads";
}

class AppConstants{
  static const bool isDebug = false;
}