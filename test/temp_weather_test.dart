import 'dart:convert';

import 'package:fashion4cast/models/temp_weather.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_test/flutter_test.dart';

// void main() {
//   final body = json.decode("{\"summery\": \"Partly Cloudy\",\"icon\": \"clear-day\","
//       "\"alert\": null,\"pressure\": 1013.2,\"temperature\": 88.88,\"description\": \"No precipitation throughout the week.\","
//       "\"humidity\": 0.28,\"pressure_daily\": 1010.7,\"max_temp\": 88.88,\"min_temp\": 86.8,\"chance_of_rain\": 0, "
//       "\"day\":\"Mon\", \"wind_direction\": 154}");
//
//   TempWeather tempWeather = TempWeather.fromJson(body);
//
//   group('Given TempWeather from json', () {
//     test('TempWeather converts correctly to CurrentWeather', () {
//
//       var currentWeather = tempWeather.toCurrentWeather(0);
//
//       expect(currentWeather.icon, 'clear-day');
//       expect(currentWeather.humidity, 0.28);
//       expect(currentWeather.wind_direction, 154);
//       expect(currentWeather.description, 'No precipitation throughout the week.');
//     });
//
//     test('TempWeather converts correctly to Weather', () {
//
//       var weather = tempWeather.toWeather(0);
//
//       expect(weather.icon, 'clear-day');
//       expect(weather.max_temp, 88.88);
//       expect(weather.min_temp, 86.80);
//       expect(weather.day, 'Mon');
//     });
//
//     test('Weather getWindDirection is correct', () {
//
//       var currentWeather = tempWeather.toCurrentWeather(0);
//
//       expect(TempWeather.getWindDirection(currentWeather.wind_direction), 'SSE');
//     });
//
//     test('Weather getWeatherIcon is correct', () {
//
//       var currentWeather = tempWeather.toCurrentWeather(0);
//
//       expect(TempWeather.getWeatherIcon(currentWeather.icon), WeatherIcons.wi_forecast_io_clear_day);
//     });
//
//     test('Weather temperature in celsuis is current', () {
//
//       var currentWeather = tempWeather.toCurrentWeather(0);
//
//       expect(TempWeather.getTemperature(currentWeather.temperature, false), "32°");
//     });
//
//   });
// }