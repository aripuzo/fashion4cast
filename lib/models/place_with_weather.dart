import 'package:fashion4cast/models/place.dart';
import 'package:fashion4cast/models/temp_weather.dart';

class PlaceWithWeather {

  PlaceWithWeather(this.place, this.weather);

  final Place place;
  final TempWeather weather;
}