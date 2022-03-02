import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'alert.dart';

class TempWeather {
  int id = 0;
  String summery;
  String icon;
  List<Alert> alert;
  double pressure;
  double temperature;
  String description;
  double humidity;
  double chanceOfRain;
  int windDirection;
  double windSpeed;
  double pressureDaily;
  double minTemp;
  double maxTemp;
  String day;
  String date;
  bool isToday;
  int timestamp;
  String background;
  String hour;
  bool isCurrentHour;

  TempWeather({
    this.summery,
    this.icon,
    this.alert,
    this.pressure,
    this.temperature,
    this.description,
    this.humidity,
    this.chanceOfRain,
    this.windDirection,
    this.pressureDaily,
    this.minTemp,
    this.maxTemp,
    this.day,
    this.date,
    this.isToday,
    this.windSpeed,
    this.timestamp,
    this.background,
    this.hour,
    this.isCurrentHour,
  });

  factory TempWeather.fromJson(Map<String, dynamic> json){
    var temp = TempWeather(
      summery: json["summery"],
      icon: json["icon"],
      temperature: checkDouble(json["temperature"]),
      description: json["description"],
      windDirection: json["wind_direction"],
      date: json["date"],
    );
    if(json.containsKey("is_today")){
      temp.isToday = json["is_today"];
    }
    if(json.containsKey("day")){
      temp.day = json["day"];
    }
    if(json.containsKey("humidity")){
      temp.humidity = double.parse((json["humidity"].toDouble()).toStringAsFixed(2));
    }
    if(json.containsKey("pressure")) {
      temp.pressure = double.parse((json["pressure"].toDouble()).toStringAsFixed(2));
    }
    if(json.containsKey("pressure_daily")){
      temp.pressureDaily = json["pressure_daily"].toDouble();
    }
    if(json.containsKey("chance_of_rain"))
      temp.chanceOfRain = double.parse((json["chance_of_rain"].toDouble()).toStringAsFixed(2));
    if(json.containsKey("min_temp")){
      temp.minTemp = double.parse((json["min_temp"].toDouble()).toStringAsFixed(2));
      temp.maxTemp = double.parse((json["max_temp"].toDouble()).toStringAsFixed(2));
    }
    if(json.containsKey("wind_speed")) {
      temp.windSpeed =
          double.parse((json["wind_speed"].toDouble()).toStringAsFixed(2));
    }
    if(json.containsKey("timestamp"))
      temp.timestamp =  json["timestamp"].toInt();
    if(json.containsKey("background"))
      temp.background = json["background"];
    if(json.containsKey("is_current_hour"))
      temp.isCurrentHour = json["is_current_hour"];
    if(json.containsKey("hour"))
      temp.hour = json["hour"];
//    if(json.containsKey("alert") && json["alert"] != null){
//      temp.alert = List<Alert>.from(json["alert"].map((x) => x));
//    }

    return temp;
  }

  Map<String, dynamic> toJson() => {
    "summery": summery,
    "icon": icon,
    "alert": alert,
    "pressure": pressure,
    "temperature": temperature,
    "description": description,
    "humidity": humidity,
    "chance_of_rain": chanceOfRain,
    "wind_direction": windDirection,
    "pressure_daily": pressureDaily,
    "min_temp": minTemp,
    "max_temp": maxTemp,
    "day": day,
    "date": date,
    "is_today": isToday,
    "wind_speed": windSpeed,
    "timestamp": timestamp,
    "background": background
  };

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    }
    else if(value is int){
      return value.toDouble();
    }
    else {
      return value;
    }
  }

  // Weather toWeather(int placeId){
  //   return Weather(
  //     id: "$placeId$day",
  //     placeId: placeId,
  //     summery: summery,
  //     icon: icon,
  //     description: description,
  //     min_temp: minTemp,
  //     max_temp: maxTemp,
  //     day: day,
  //     date: date,
  //     is_today: isToday,
  //     timestamp: timestamp
  //   );
  // }
  //
  // CurrentWeather toCurrentWeather(int placeId){
  //   return CurrentWeather(
  //     placeId: placeId,
  //     summery: summery,
  //     icon: icon,
  //     pressure: pressure,
  //     temperature: temperature,
  //     description: description,
  //     humidity: humidity,
  //     chance_of_rain: chanceOfRain,
  //     wind_direction: windDirection,
  //     pressure_daily: pressureDaily,
  //     min_temp: minTemp,
  //     max_temp: maxTemp,
  //     day: day,
  //     date: date,
  //     is_today: isToday,
  //     wind_speed: windSpeed,
  //     background: background
  //   );
  // }

  static IconData getWeatherIcon(String s){
    // switch(s){
    //   case "clear-day":{return WeatherIcons.wi_forecast_io_clear_day;}
    //   case "clear-night":{return WeatherIcons.wi_forecast_io_clear_night;}
    //   case "partly-cloudy-day":{return WeatherIcons.wi_forecast_io_partly_cloudy_day;}
    //   case "partly-cloudy-night":{return WeatherIcons.wi_forecast_io_partly_cloudy_night;}
    //   case "heavy-showers":{return WeatherIcons.wi_day_showers;}
    //   case "rain":{return WeatherIcons.wi_rain;}
    //   case "sunny":{return WeatherIcons.wi_day_sunny;}
    //   case "cloudy":{return WeatherIcons.wi_cloudy;}
    //   case "snow":{return WeatherIcons.wi_snow;}
    //   case "fog":{return WeatherIcons.wi_fog;}
    //   case "hail":{return WeatherIcons.wi_hail;}
    //   case "hot":{return WeatherIcons.wi_hot;}
    //   case "windy":{return WeatherIcons.wi_windy;}
    //   default: return WeatherIcons.wi_forecast_io_clear_day;
    // }
    switch(s){
      case "01d":{return WeatherIcons.wi_forecast_io_clear_day;}
      case "01n":{return WeatherIcons.wi_forecast_io_clear_night;}
      case "02d":{return WeatherIcons.wi_forecast_io_partly_cloudy_day;}
      case "02n":{return WeatherIcons.wi_forecast_io_partly_cloudy_night;}
      case "09d":{return WeatherIcons.wi_day_showers;}
      case "09n":{return WeatherIcons.wi_night_showers;}
      case "10d":{return WeatherIcons.wi_rain;}
      case "10n":{return WeatherIcons.wi_night_rain;}
      case "sunny":{return WeatherIcons.wi_day_sunny;}
      case "04d":{return WeatherIcons.wi_cloudy;}
      case "13d":{return WeatherIcons.wi_day_snow;}
      case "13n":{return WeatherIcons.wi_night_snow;}
      case "50d":{return WeatherIcons.wi_day_fog;}
      case "50n":{return WeatherIcons.wi_night_fog;}
      case "50d":{return WeatherIcons.wi_hail;}
      case "01d":{return WeatherIcons.wi_hot;}
      case "50d":{return WeatherIcons.wi_windy;}
      default: return WeatherIcons.wi_forecast_io_clear_day;
    }
  }

  static String getWindDirection(int d){
    if (d >= 0 && d <= 16)
      return "N";
    if (d >= 17 && d <= 38)
      return "NNE";
    if (d >= 39 && d <= 61)
      return "NE";
    if (d >= 62 && d <= 84)
      return "ENE";
    if (d >= 85 && d <= 106)
      return "E";
    if (d >= 107 && d <= 129)
      return "ESE";
    if (d >= 130 && d <= 151)
      return "SE";
    if (d >= 152 && d <= 174)
      return "SSE";
    if (d >= 174 && d <= 196)
      return "S";
    if (d >= 197 && d <= 219)
      return "SSW";
    if (d >= 220 && d <= 241)
      return "SW";
    if (d >= 242 && d <= 264)
      return "WSW";
    if (d >= 265 && d <= 287)
      return "W";
    if (d >= 288 && d <= 309)
      return "WNW";
    if (d >= 310 && d <= 332)
      return "NW";
    if (d >= 333 && d <= 345)
      return "NNW";
    return "N";
  }

  static String getTemperature(double temp, bool isF){
    if(!isF)
      return "${(((temp - 32)*5)/9).round()}°";
    else
      return "${temp.round()}°";
  }

  String getMaxTemperature(bool isF){
    if(!isF)
      return "${(((maxTemp - 32)*5)/9).round()}°";
    else
      return "${maxTemp.round()}°";
  }

  String getMinTemperature(bool isF){
    if(!isF)
      return "${(((minTemp - 32)*5)/9).round()}°";
    else
      return "${minTemp.round()}°";
  }

  static String getArrow(double pressure, double pressureDaily){
    return (pressure > pressureDaily) ? "assets/images/arrow_green.png" : "assets/images/arrow_red.png";
  }
}