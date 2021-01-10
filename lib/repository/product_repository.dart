import 'dart:async';

import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/product.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:meta/meta.dart';

class ProductRepository {

  AppPreferences _appPreferences;
  var _productController = StreamController<List<Product>>.broadcast();

  factory ProductRepository({@required AppPreferences appPreferences})=> ProductRepository._internal(appPreferences);

  ProductRepository._internal(this._appPreferences);

  void loadProducts(String condition){
    Api.initialize().getProducts(condition).then((result) {
      if (result != null && result.data != null) {
        _productController.add(result.data);
        //App().appDatabase.productDao.replaceProducts(result.data);
      }
    });
  }

  Stream<List<Product>> getProducts() => _productController.stream;

  // Stream<List<Product>> getProducts() {
  //   return App().appDatabase.productDao.watchAllProducts();
  // }

}