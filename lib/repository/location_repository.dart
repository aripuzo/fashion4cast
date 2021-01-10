import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:meta/meta.dart';

class LocationRepository {

  var _placesObserver = StreamController<List<Place>>.broadcast();
  var _placesErrorObserver = StreamController<String>.broadcast();
  var _logoutErrorObserver = StreamController<bool>.broadcast();
  var _locationEmptyObserver = StreamController<bool>.broadcast();
  AppPreferences _appPreferences;
  factory LocationRepository({@required AppPreferences appPreferences})=> LocationRepository._internal(appPreferences);

  LocationRepository._internal(this._appPreferences);

  void addPlace(
      {@required String placeId}){
    Api.initialize().addPlace(placeId: placeId).then((result) {
      if (result != null && result.data != null) {
        var placeDao = App().appDatabase.placeDao;
        placeDao.insertPlace(result.data);
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
    Api.initialize().getWeatherCurrent(placeId).then((result) {
      if (result != null && result.data != null) {
        var weatherDao = App().appDatabase.currentWeatherDao;
        weatherDao.replaceWeather(result.data.weather, result.data.place.id);
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
          App().appDatabase.placeDao.replacePlaces(result.data.data);
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

  Future<List<Place>> getPlaces() {
    return App().appDatabase.placeDao.getPlaces();
  }

  Stream<List<Place>> getMyPlaces() {
    return App().appDatabase.placeDao.watchAllPlaces();
  }

  Stream<List<Place>> getPlacesResponse() {
    return _placesObserver.stream;
  }

  Stream<String> getPlacesError() {
    return _placesErrorObserver.stream;
  }

  Stream<bool> getLogoutError() {
    return _logoutErrorObserver.stream;
  }

  Stream<bool> getEmptyLocationError() {
    return _locationEmptyObserver.stream;
  }

}