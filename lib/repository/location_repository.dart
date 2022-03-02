import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/databases/dao/place_dao.dart';
import 'package:fashion4cast/models/place.dart';
import 'package:fashion4cast/models/temp_weather.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:meta/meta.dart';

class LocationRepository {

  var _placesObserver = StreamController<List<Place>>.broadcast();
  var _placesErrorObserver = StreamController<String>.broadcast();
  var _logoutErrorObserver = StreamController<bool>.broadcast();
  var _locationEmptyObserver = StreamController<bool>.broadcast();
  var _hourlyController = StreamController<List<TempWeather>>.broadcast();
  var _historyController = StreamController<List<TempWeather>>.broadcast();

  AppPreferences _appPreferences;
  var placeDao = PlaceDao();
  var weatherDao = App().getWeatherDao();
  factory LocationRepository({@required AppPreferences appPreferences})=> LocationRepository._internal(appPreferences);

  LocationRepository._internal(this._appPreferences);

  void addPlace(
      {@required String placeId}){
    Api.initialize().addPlace(placeId: placeId).then((result) {
      if (result != null && result.data != null) {
        placeDao.getPlace(result.data.id).then((value) => {
          if(value != null)
            placeDao.update(result.data)
          else
            placeDao.insert(result.data)
        });
        _placesErrorObserver.add(null);
        placeDao.getPlaces().then((value) => (value.length <= 1) ? setDefaultPlace(result.data.id) : null);
        getCurrentWeather(placeId: result.data.externalId);
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
        if(!_appPreferences.useCurrentLocation()) {
          for (int i = 0; i < result.data.weather.length; i++) {
            if (result.data.weather[i].isToday)
              weatherDao.insert(result.data.weather[i], result.data.place);
          }
          _hourlyController.add(result.data.hourly);
          _historyController.add(result.data.weather);
        }
      }
    });
  }

  void getWeatherCoordinate({@required double lat, @required double lng}) async{
    Api.initialize().getWeatherCoordinate(lat, lng).then((result) {
      if (result != null && result.data != null) {
        //var weatherDao = App().appDatabase.currentWeatherDao;
        for (int i = 0; i < result.data.weather.length; i++){
          if (result.data.weather[i].isToday) {
            weatherDao.insert(result.data.weather[i], result.data.place);
            placeDao.insert(result.data.place);
          }
        }
        _hourlyController.add(result.data.hourly);
        _historyController.add(result.data.weather);
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
            getCurrentWeather(placeId: result.data.data[i].externalId);
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

  Stream<List<TempWeather>> getHourly() => _hourlyController.stream;

  Stream<List<TempWeather>> getHistory() => _historyController.stream;

}