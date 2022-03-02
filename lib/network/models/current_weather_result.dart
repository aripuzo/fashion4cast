import 'package:fashion4cast/models/place.dart';
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
  List<TempWeather> hourly;
  String timezone;

  Data({
    this.place,
    this.weather,
    this.hourly,
    this.timezone
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    place: Place.fromJson(json["place"]),
    weather: TempWeather.fromJson(json["weather"]),
    hourly: List<TempWeather>.from(json["hourly"].map((x) => TempWeather.fromJson(x))),
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "place": place.toJson(),
    "weather": weather.toJson(),
    "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
    "timezone": timezone,
  };
}