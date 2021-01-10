class DeviceResult {
  List<dynamic> data;
  String message;
  bool errors;

  DeviceResult({
    this.data,
    this.message,
    this.errors,
  });

  factory DeviceResult.fromJson(Map<String, dynamic> json) => DeviceResult(
    //data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    //"data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
    "errors": errors,
  };
}