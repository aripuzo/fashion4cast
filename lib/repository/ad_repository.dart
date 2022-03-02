import 'dart:async';

import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/ad.dart';
import 'package:fashion4cast/network/api.dart';
import 'package:meta/meta.dart';

class AdRepository {

  AppPreferences _appPreferences;
  factory AdRepository({@required AppPreferences appPreferences})=> AdRepository._internal(appPreferences);

  var _adController = StreamController<Ad>.broadcast();

  AdRepository._internal(this._appPreferences);

  void loadAd(){
    Api.initialize().getAd().then((result) {
      if (result != null && result.data != null) {
        _adController.add(result.data);
      }
    });
  }

  Stream<Ad> getAd() => _adController.stream;

}