import '../../databases/app_database.dart';

class PlaceAutoCompleteData {
  List<Place> data;
  String message;
  dynamic errors;

  PlaceAutoCompleteData({
    this.data,
    this.message,
    this.errors,
  });

  factory PlaceAutoCompleteData.fromJson(Map<String, dynamic> json) => PlaceAutoCompleteData(
    data: List<Place>.from(json["data"].map((x) => Place.fromJson(x))),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "errors": errors,
  };
}