import 'package:fashion4cast/models/user.dart';

class AuthData{
  String message;
  User data;
  bool errors;

  AuthData({this.data, this.message, this.errors});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    var auth = AuthData(
      message: json["message"],
      errors: json["errors"],
    );
    if(json.containsKey("data"))
      auth.data = User.fromJson(json["data"]);
    return auth;
  }

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "errors": errors,
  };

}