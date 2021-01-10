import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/models/temp_weather.dart';

class DetailWeatherResult {
  DetailWeather data;
  String message;
  dynamic errors;

  DetailWeatherResult({
    this.data,
    this.message,
    this.errors,
  });

  factory DetailWeatherResult.fromJson(Map<String, dynamic> json) => DetailWeatherResult(
    data: DetailWeather.fromJson(json["data"]),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "errors": errors,
  };
}

class DetailWeather {
  Place place;
  List<TempWeather> weather;

  DetailWeather({
    this.place,
    this.weather,
  });

  factory DetailWeather.fromJson(Map<String, dynamic> json) => DetailWeather(
    place: Place.fromJson(json["place"]),
    weather: List<TempWeather>.from(json["weather"].map((x) => TempWeather.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "place": place.toJson(),
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
  };
}