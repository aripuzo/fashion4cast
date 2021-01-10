class Errors {
  List<String> email;
  List<String> phone;
  List<String> password;
  List<String> currentPassword;

  Errors({
    this.email,
    this.phone,
    this.password,
    this.currentPassword
  });

  factory Errors.fromJson(Map<String, dynamic> json){
    var errors = Errors();
    if(json.containsKey("email"))
      errors.email = List<String>.from(json["email"].map((x) => x));
    if(json.containsKey("phone"))
      errors.phone = List<String>.from(json["phone"].map((x) => x));
    if(json.containsKey("password"))
      errors.password = List<String>.from(json["password"].map((x) => x));
    if(json.containsKey("current_password"))
      errors.currentPassword = List<String>.from(json["current_password"].map((x) => x));
    return errors;
  }

  Map<String, dynamic> toJson() => {
      "email": email,
      "phone": phone,
    };
}