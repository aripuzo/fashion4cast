class ForgotPasswordResult {
  ForgotPasswordData data;
  String messages;
  bool errors;

  ForgotPasswordResult({
    this.data,
    this.messages,
    this.errors,
  });

  factory ForgotPasswordResult.fromJson(Map<String, dynamic> json) => ForgotPasswordResult(
    data: ForgotPasswordData.fromJson(json["data"]),
    messages: json["messages"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "messages": messages,
    "errors": errors,
  };
}

class ForgotPasswordData {
  int id;
  String email;
  String token;
  DateTime expireAt;
  DateTime updatedAt;
  DateTime createdAt;

  ForgotPasswordData({
    this.id,
    this.email,
    this.token,
    this.expireAt,
    this.updatedAt,
    this.createdAt,
  });

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) => ForgotPasswordData(
    id: json["id"],
    email: json["email"],
    token: json["token"],
    expireAt: DateTime.parse(json["expire_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "token": token,
    "expire_at": expireAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}