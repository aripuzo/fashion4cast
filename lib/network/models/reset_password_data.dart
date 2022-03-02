class ResetPasswordResult {
  ResetPasswordResult({
    this.data,
    this.message,
    this.errors,
  });

  List<dynamic> data;
  String message;
  dynamic errors;

  factory ResetPasswordResult.fromJson(Map<String, dynamic> json) => ResetPasswordResult(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
    "errors": errors,
  };
}