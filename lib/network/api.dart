import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/models/ad.dart';
import 'package:fashion4cast/network/models/auth_data.dart';
import 'package:fashion4cast/network/models/detail_weather_result.dart';
import 'package:fashion4cast/network/models/places_autocomplete_data.dart';
import 'package:fashion4cast/network/models/places_result.dart';
import 'package:fashion4cast/network/models/product_result.dart';
import 'package:fashion4cast/network/models/reset_password_data.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'models/current_weather_result.dart';
import 'models/device_result.dart';
import 'models/forgot_password_data.dart';
import 'models/register_auth_data.dart';
import 'models/string_data.dart';
import 'models/user_data.dart';
import 'network_endpoints.dart';

class Api {
  Dio dio;
  Logger logger;

  Api.initialize() {
    dio = Dio()
      ..options.baseUrl = NetworkEndpoints.BASE_API
      ..options.connectTimeout = 60000
      ..options.receiveTimeout = 60000
      ..options.responseType = ResponseType.json
      ..options.headers = {"Authorization" : "Bearer ${App().getAppPreferences().getToken()}",
        "Accept": "application/json"
      }
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    logger = Logger();
  }

  ///SignIn
  Future<AuthData> singIn({@required String email,
  @required String password}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.LOGIN_API,
          data: {
            "identity": email,
            "password": password
          });
      //final int statusCode = response.statusCode;
      if (response == null || response.data == null) {
        throw new Exception("Error while fetching data");
      }
      return AuthData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        return AuthData.fromJson(e.response.data);
      }
      return null;
    }
  }

  ///Create User
  Future<RegisterAuthData> createUserDio(
      {@required String firstName, @required String lastName,
    @required String userEmail,
    @required String userPhone, @required String countryCode,
    @required String userPassword}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.REGISTER_API,
          data: {
            "first_name": firstName,
            "last_name": lastName,
            "country_code": countryCode,
            "email": userEmail,
            "phone": userPhone,
            "password": userPassword
          });
      if (response == null || response.data == null) {
        throw new Exception("Error while fetching data");
      }
      return RegisterAuthData.fromJson(response.data);
    }on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        var result = RegisterAuthData.fromJson(e.response.data);
        //print(result.toJson().toString());
        if(result != null)
        return result;
      }
      return null;
    }
  }

  ///Forgot password
  Future<ForgotPasswordResult> forgotPassword({@required String email}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.FORGOT_PASSWORD_API,
          data: {
            "email": email,
          });
      int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return ForgotPasswordResult.fromJson(response.data);
    } on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      return null;
    }
  }

  ///Reset password
  Future<ResetPasswordResult> resetPassword({@required String email,
    @required String password, @required String token}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.RESET_PASSWORD_API,
          data: {
            "email": email,
            "password": password,
            "token": token,
          });
      int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return ResetPasswordResult.fromJson(response.data);
    } on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      return null;
    }
  }

  Future<UserData> updateUser(
      {@required String firstName, @required String lastName,
        @required String userEmail}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.ACCOUNT_PROFILE_API,
          data: {
            "first_name": firstName,
            "last_name": lastName,
            "email": userEmail,
          });
      if (response == null || response.data == null) {
        throw new Exception("Error while fetching data");
      }
      return UserData.fromJson(response.data);
    }on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        var result = UserData.fromJson(e.response.data);
        //print(result.toJson().toString());
        if(result != null)
          return result;
      }
      return null;
    }
  }

  ///Create User
  Future<UserData> changePassword(
      {@required String currentPassword, @required String password,
        @required String confirmPassword}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.ACCOUNT_CHANGE_PASSWORD_API,
          data: {
            "current_password": currentPassword,
            "password": password,
            "confirm_password": confirmPassword,
          });
      if (response == null || response.data == null) {
        throw new Exception("Error while fetching data");
      }
      return UserData.fromJson(response.data);
    }on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        var result = UserData.fromJson(e.response.data);
        //print(result.toJson().toString());
        if(result != null)
          return result;
      }
      return null;
    }
  }

  Future<StringData> updateImage(
      {@required File file}) async {
    try {
      String fileName = file.path.split("/").last;
      var formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      Response response = await dio.post(NetworkEndpoints.ACCOUNT_AVATAR_API, data: formData);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return StringData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        var result = StringData.fromJson(e.response.data);
        if(result != null)
          return result;
      }
      return null;
    }
  }

  Future<DeviceResult> addDevice({@required String deviceId}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.ACCOUNT_DEVICES_API,
          data: {
            "device_id": deviceId,
            "platform": Platform.isAndroid ? "Android" : "IOS"
          });
      if (response == null || response.data == null) {
        throw new Exception("Error while fetching data");
      }
      return DeviceResult.fromJson(response.data);
    } on DioError {
      return null;
    }
  }

  ///Add Place
  Future<PlaceData> addPlace({@required String placeId}) async {
    try {
      Response response = await dio.post(NetworkEndpoints.PLACES_ADD_API,
          data: {
            "place_id": placeId
          });
      if (response == null || response.data == null) {
        throw new Exception("Error while fetching data");
      }
      return PlaceData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        return PlaceData.fromJson(e.response.data);
      }
      return null;
    }
  }

  Future<PlaceResult> getMyPlaces() async {
    try {
      Response response = await dio.get(NetworkEndpoints.PLACES_API);
      return PlaceResult.fromJson(response.data);
    } on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        var result = PlaceResult.fromJson(e.response.data);
        if(result != null)
          return result;
      }
      else {
        var result = PlaceResult(data: null, message: "Error connecting", errors: null);
        if(result != null)
          return result;
      }
      return null;
    }
  }

  Future<PlaceAutoCompleteData> getPlacesAutocomplete(String query) async {
    try {
      Response response = await dio.get(NetworkEndpoints.PLACES_AUTOCOMPLETE_API,
          queryParameters: {
            "query": query
          });
      return PlaceAutoCompleteData.fromJson(response.data);
    } on DioError catch (e) {
      return null;
    }
  }

  Future<CurrentWeatherResult> getWeatherCurrent(String placeId) async {
    try {
      Response response = await dio.get(NetworkEndpoints.WEATHER_API,
          queryParameters: {
            "place_id": placeId,
            "payload": "current"
          });
      return CurrentWeatherResult.fromJson(response.data);
    } on DioError {
      return null;
    }
  }

  Future<DetailWeatherResult> getWeatherDetail(String placeId) async {
    try {
      Response response = await dio.get(NetworkEndpoints.WEATHER_API,
          queryParameters: {
            "place_id": placeId,
            "payload": "detail"
          });
      return DetailWeatherResult.fromJson(response.data);
    } on DioError {
      return null;
    }
  }

  Future<DetailWeatherResult> getWeatherCoordinate(double lat, double lng) async {
    try {
      Response response = await dio.get(NetworkEndpoints.WEATHER_API + "/coordinate",
          queryParameters: {
            "lat": lat,
            "lng": lng,
            "payload": "detail"
          });
      return DetailWeatherResult.fromJson(response.data);
    } on DioError {
      return null;
    }
  }

  Future<ProductResult> getProducts(String condition) async {
    try {
      Response response = await dio.get(NetworkEndpoints.PRODUCT_API,
          queryParameters: {
            "payload": "detail",
            "condition": condition
          });
      return ProductResult.fromJson(response.data);
    } on DioError {
      return null;
    }
  }

  Future<AdResult> getAd() async {
    try {
      Response response = await dio.get(NetworkEndpoints.AD_API);
      return AdResult.fromJson(response.data);
    } on DioError {
      return null;
    }
  }

  Future<PlaceData> deleteAccount() async {
    try {
      Response response = await dio.post(NetworkEndpoints.DELETE_ACCOUNT_API,
          data: {
          });
      if (response == null || response.data == null) {
        throw new Exception("Error while fetching data");
      }
      return PlaceData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e('''Error message is ${e.message}
                  Error type is ${e.type}
                  Error is ${e.error}
                  For request ${e.requestOptions}
                  And Response ${e.response != null ? 'request => ${e.response.requestOptions} and data => ${e.response.data} headers => ${e.response.headers}' : 'request is ${e.requestOptions}'}
                  Stacktrace is ${e.toString()}'''
      );
      if (e.response != null && e.response.data != null) {
        return PlaceData.fromJson(e.response.data);
      }
      return null;
    }
  }
}