import 'dart:async';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/models/ad.dart';
import 'package:fashion4cast/models/product.dart';
import 'package:fashion4cast/repository/ad_repository.dart';
import 'package:fashion4cast/repository/product_repository.dart';
import 'package:flutter/material.dart';

class WeeklySuggestionViewModel{

  // -------------------------------------------------------- Variables -----------------------------------------------------------------------------
  ProductRepository _productRepository;
  AdRepository _adRepository;
  Place _place;

  static WeeklySuggestionViewModel _instance;
  // STREAM CONTROLLER for broadcasting login response
  var _myAdController = StreamController<Ad>.broadcast();
  var _myProductsController = StreamController<List<Product>>.broadcast();

  // ---------------------------------------------------------- Constructor --------------------------------------------------------------------------

  factory WeeklySuggestionViewModel(App app, Place place){
    _instance
    ??= // NULL Check
    WeeklySuggestionViewModel._internal(adRepository: app.getAdRepository(appPreferences: app.getAppPreferences()),
        productRepository: app.getProductRepository(appPreferences: app.getAppPreferences()), place: place);
    return _instance;
  }

  WeeklySuggestionViewModel._internal({@required AdRepository adRepository,
    @required ProductRepository productRepository, @required Place place}){
    _place = place;
    _adRepository = adRepository;
    _productRepository = productRepository;
    _init();
  }

  // ---------------------------------------------------------- View Model Methods -------------------------------------------------------------------

  void _init() {
    _listenRegisterResponse();
  }

  void refreshProducts(String condition){
    //_weatherRepository.getDetailWeather(placeId: _place.external_id);
    _productRepository.loadProducts(condition);
  }

  void loadAd(){
    _adRepository.loadAd();
  }

  void _listenRegisterResponse(){
    _adRepository.getAd()
        .listen(
            (ad){
          _myAdController.add(ad);
        }
    );

    _productRepository.getProducts().listen((products) {
      _myProductsController.add(products);
    });
  }

  Stream<Ad> getAd() => _myAdController.stream;

  Stream<List<Product>> getProducts() => _myProductsController.stream;

}