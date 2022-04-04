import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/temp_weather.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:meta/meta.dart';


class LocationRepository {

  var _placesObserver = StreamController<List<Place>>.broadcast();
  var _placesErrorObserver = StreamController<String>.broadcast();
  var _logoutErrorObserver = StreamController<bool>.broadcast();
  var _locationEmptyObserver = StreamController<bool>.broadcast();

  AppPreferences _appPreferences;
  var placeDao = App().getPlaceDao();
  var weatherDao = App().getWeatherDao();
  factory LocationRepository({@required AppPreferences appPreferences})=> LocationRepository._internal(appPreferences);

  LocationRepository._internal(this._appPreferences);

  void addPlace(
      {@required String placeId}){
    Api.initialize().addPlace(placeId: placeId).then((result) {
      if (result != null && result.data != null) {
        placeDao.getPlace(result.data.id).then((value) => {
          if(value != null)
            placeDao.updatePlace(result.data)
          else
            placeDao.updatePlace(result.data)
        });
        _placesErrorObserver.add(null);
        placeDao.getPlaces().then((value) => (value.length <= 1) ? setDefaultPlace(result.data.id) : null);
        getCurrentWeather(placeId: result.data.external_id);
      } else {
        String message;
        if(result != null && (message == null || message.isEmpty))
          message = result.message;
        else if(message == null)
          message = "Error adding location";

        _placesErrorObserver.add(message);
      }
    });
  }

  void getCurrentWeather({@required String placeId}) async{
    Api.initialize().getWeatherDetail(placeId).then((result) {
      if (result != null && result.data != null) {
        TempWeather tempWeather;
        for (int i = 0; i < result.data.weather.length; i++) {
          if (result.data.weather[i].isToday)
            tempWeather = result.data.weather[i];
        }
        if(tempWeather != null) {
          tempWeather.hourly = result.data.hourly;
          tempWeather.history = result.data.weather;
          weatherDao.insert(tempWeather, result.data.place);
        }
      }
    });
  }

  void getWeatherCoordinate({@required double lat, @required double lng}) async{
    Api.initialize().getWeatherCoordinate(lat, lng).then((result) {
      if (result != null && result.data != null) {
        TempWeather tempWeather;
        for (int i = 0; i < result.data.weather.length; i++){
          if (result.data.weather[i].isToday) {
            tempWeather = result.data.weather[i];
            placeDao.updatePlace(result.data.place);
          }
        }
        if(tempWeather != null) {
          tempWeather.hourly = result.data.hourly;
          tempWeather.history = result.data.weather;
          weatherDao.insert(tempWeather, result.data.place);
        }
      }
    });
  }

  void setDefaultPlace(int placeId){
    _appPreferences.setDefaultPlace(placeId: placeId);
  }

  void loadAutocompletePlaces(String s){
    Api.initialize().getPlacesAutocomplete(s)
        .then((result) {
      if (result != null && result.data.isNotEmpty) {
        _placesObserver.add(result.data);
      }
    });
  }

  void loadMyPlaces(){
    Api.initialize().getMyPlaces()
        .then((result) {
      if (result != null && result.data != null && result.data.data != null) {
        if(result.data.data.isNotEmpty) {
          placeDao.insertMore(result.data.data);
          for (int i = 0; i < result.data.data.length; i++)
            getCurrentWeather(placeId: result.data.data[i].external_id);
        }
        else
          _locationEmptyObserver.add(true);
      }
      else if(result != null && result.message == "Unauthenticated.") {
        _logoutErrorObserver.add(true);
      }
    });
  }

  Stream<List<Place>> getPlacesResponse() {
    return _placesObserver.stream;
  }

  Future<List<Place>> getPlaces() => placeDao.getPlaces();

  Stream<List<Place>> getMyPlaces() => placeDao.getPlaces().asStream();

  Stream<String> getPlacesError() => _placesErrorObserver.stream;

  Stream<bool> getLogoutError() => _logoutErrorObserver.stream;

  Stream<bool> getEmptyLocationError() =>_locationEmptyObserver.stream;

}