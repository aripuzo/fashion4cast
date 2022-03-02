import 'package:fashion4cast/models/user.dart';

import 'errors.dart';

class UserData{
  String message;
  User data;
  Errors errors;

  UserData({this.data, this.message, this.errors});

  factory UserData.fromJson(Map<String, dynamic> json){
    var result = UserData(
      message: json["message"],
      errors: json["errors"],
    );
    if(json.containsKey("data"))
      result.data = User.fromJson(json["data"]);
    return result;
  }

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "errors": errors,
  };

}