import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/models/place.dart';
import 'package:fashion4cast/repository/location_repository.dart';
import 'package:flutter/material.dart';

class SelectLocationViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  LocationRepository _locationRepository;

  static SelectLocationViewModel _instance;
  // STREAM CONTROLLER for broadcasting login response
  var _myPlacesController = StreamController<List<Place>>.broadcast();

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory SelectLocationViewModel(App app){
    _instance
    ??= // NULL Check
    SelectLocationViewModel._internal(gamePlayRepository: app.getLocationRepository(appPreferences: app.getAppPreferences()));
    return _instance;
  }

  SelectLocationViewModel._internal({@required LocationRepository gamePlayRepository}){
    //_registerFormObserver = registerFormObserver;
    _locationRepository = gamePlayRepository;
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    _listenRegisterResponse();
  }

  void loadPlaces(){
    _locationRepository.loadMyPlaces();
  }

  void _listenRegisterResponse(){
    _locationRepository.getMyPlaces()
        .listen(
            (places){
          _myPlacesController.add(places);
        }
    );
  }

  void setDefaultPlace(int placeId) {
    _locationRepository.setDefaultPlace(placeId);
  }

  Stream<List<Place>> getMyPlaces() => _myPlacesController.stream;

}