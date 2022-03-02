class StringData{
  String message;
  String data;
  bool errors;

  StringData({this.data, this.message, this.errors});

  factory StringData.fromJson(Map<String, dynamic> json) {
    var auth = StringData(
      message: json["message"],
      errors: json["errors"],
      data: json["data"]
    );
    return auth;
  }

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "errors": errors,
  };

}