class User{
  int id;
  String firstName;
  String lastName;
  String countryCode;
  String phone;
  String email;
  String token;
  String avatar;

  User({this.id, this.firstName, this.lastName, this.phone, this.email, this.token, this.countryCode, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    countryCode: json["country_code"],
    phone: json["phone"],
    email: json["email"],
    token: json["token"],
    avatar: json["avatar"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "country_code": countryCode,
    "phone": phone,
    "email": email,
    "token": token,
    "avatar": avatar
  };

  String name(){
    return "$firstName $lastName";
  }

}