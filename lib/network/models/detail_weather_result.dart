import 'package:fashion4cast/models/place.dart';
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
  List<TempWeather> hourly;
  String timezone;

  DetailWeather({
    this.place,
    this.weather,
    this.hourly,
    this.timezone
  });

  factory DetailWeather.fromJson(Map<String, dynamic> json) => DetailWeather(
    place: Place.fromJson(json["place"]),
    weather: List<TempWeather>.from(json["weather"].map((x) => TempWeather.fromJson(x))),
    hourly: List<TempWeather>.from(json["hourly"].map((x) => TempWeather.fromJson(x))),
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "place": place.toJson(),
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
    "timezone": timezone,
  };
}