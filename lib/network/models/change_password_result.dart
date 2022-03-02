import 'errors.dart';

class ChangePasswordResult {
  String message;
  Errors errors;

  ChangePasswordResult({
    this.message,
    this.errors,
  });

  factory ChangePasswordResult.fromJson(Map<String, dynamic> json) => ChangePasswordResult(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}