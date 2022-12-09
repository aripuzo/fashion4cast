import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/form_observers/add_location_form_observers.dart';
import 'package:fashion4cast/repository/location_repository.dart';
import 'package:flutter/material.dart';

import '../databases/app_database.dart';


class AddLocationViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  LocationRepository _locationRepository;
  AddLocationFormObserver _addLocationFormObserver;

  String lastQuery;
  bool isLoading = false;

  static AddLocationViewModel _instance;
  // STREAM CONTROLLER for broadcasting login response
  final queryController = TextEditingController();
  var _placeResultController = StreamController<String>.broadcast();
  var _placesController = StreamController<List<Place>>.broadcast();

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory AddLocationViewModel(App app){
    _instance
    ??= // NULL Check
    AddLocationViewModel._internal(formObserver: AddLocationFormObserver(), gamePlayRepository: app.getLocationRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  AddLocationViewModel._internal({@required AddLocationFormObserver formObserver, @required LocationRepository gamePlayRepository}){
    _addLocationFormObserver = formObserver;
    _locationRepository = gamePlayRepository;
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    _listenRegisterResponse();
    queryController.addListener(() {
      if(queryController.text.length > 1){
        searchPlace(queryController.text);
      }
      else if(queryController.text.length == 0) {
        List<Place> places = [];
        _placesController.add(places);
      }
    });
  }

  void _listenRegisterResponse(){

    _locationRepository.getPlacesResponse()
        .listen(
            (places){
          _placesController.add(places);
        }
    );

    _locationRepository.getPlacesError()
        .listen(
            (questions){
          _placeResultController.add(questions);
        }
    );
  }

  void refreshWeather() async{
    _locationRepository.loadMyPlaces();
  }

  void addPlace(String placeId) {
    _locationRepository.addPlace(placeId: placeId);
  }

  void searchPlace(String query) {
    if(query != lastQuery) {
      lastQuery = query;
      _locationRepository.loadAutocompletePlaces(lastQuery);
    }
  }

  void clear(){
    queryController.clear();
  }

  Stream<String> getPlaceResultStream() => _placeResultController.stream;

  Stream<List<Place>> getPlaces() => _placesController.stream;

}