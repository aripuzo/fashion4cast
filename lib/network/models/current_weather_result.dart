import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/models/temp_weather.dart';

class CurrentWeatherResult {
  Data data;
  String message;
  dynamic errors;

  CurrentWeatherResult({
    this.data,
    this.message,
    this.errors,
  });

  factory CurrentWeatherResult.fromJson(Map<String, dynamic> json) => CurrentWeatherResult(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "errors": errors,
  };
}

class Data {
  Place place;
  TempWeather weather;

  Data({
    this.place,
    this.weather,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    place: Place.fromJson(json["place"]),
    weather: TempWeather.fromJson(json["weather"]),
  );

  Map<String, dynamic> toJson() => {
    "place": place.toJson(),
    "weather": weather.toJson(),
  };
}