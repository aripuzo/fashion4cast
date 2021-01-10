import 'package:fashion4cast/models/user.dart';
import 'package:fashion4cast/network/models/errors.dart';

class RegisterAuthData{
  String message;
  User data;
  Errors errors;

  RegisterAuthData({this.data, this.message, this.errors});

  factory RegisterAuthData.fromJson(Map<String, dynamic> json) {
    var auth = RegisterAuthData(
      message: json["message"],
    );
    if(json.containsKey("errors") && json["errors"] != null)
      auth.errors = Errors.fromJson(json["errors"]);
    if(json.containsKey("data"))
      auth.data = User.fromJson(json["data"]);
    return auth;
  }

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "errors": errors?.toJson(),
  };

}