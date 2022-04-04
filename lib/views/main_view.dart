import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/alert.dart';
import 'package:fashion4cast/models/place_with_weather.dart';
import 'package:fashion4cast/models/temp_weather.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_styles.dart';
import 'package:fashion4cast/view_models/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

import 'weekly_forecast_view.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppStyles.defaultTheme(),
      debugShowCheckedModeBanner: false,
      home: _MainView(),
      onGenerateRoute: App().getAppRoutes().getRoutes,
    );
  }
}

class _MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<_MainView> {
  int _currentIndex = 0;

  PlaceWithWeather _currentWeather;

  MainViewModel _viewModel;

  int _selected;

  List<PlaceWithWeather> _trans = [];
  List<Alert> _alert = [];

  String formattedDate;

  bool _isFetching = true;

  bool _connected = true;

  String _emptyMessage = "Fetching location";

  AppPreferences pref;

  ScrollController _controller;

  String _bgImage;

  var safeWidth;

  var safeHeight;

  var physicalScreenSize = window.physicalSize;

  var historyTotal = 4;

  var hasLocationPermission = true;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    _viewModel = MainViewModel(App());
    subscribeToViewModel();

    pref = App().getAppPreferences();

    _selected = pref.getDefaultPlace();

    var now = new DateTime.now();
    formattedDate = "Today, ${DateFormat('EEEE d MMMM').format(now)}";

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    if (!pref.hasDevice()) _saveDeviceId();

    var logicalScreenSize = window.physicalSize / window.devicePixelRatio;

//Safe area paddings in logical pixels
    var paddingLeft = window.padding.left / window.devicePixelRatio;
    var paddingRight = window.padding.right / window.devicePixelRatio;
    var paddingTop = window.padding.top / window.devicePixelRatio;
    var paddingBottom = window.padding.bottom / window.devicePixelRatio;

//Safe area in logical pixels
    safeWidth = logicalScreenSize.width - paddingLeft - paddingRight;
    safeHeight = logicalScreenSize.height - paddingTop - paddingBottom;

    if(pref.useCurrentLocation())
      _getCurrentPosition();

    _viewModel.refreshWeather();

    super.initState();
  }

  _openForecast({@required PlaceWithWeather weather}) {
    if (_connected) {
      Navigator.pushNamed(
        context,
        AppRoutes.APP_ROUTE_WEEKLY_FORECAST,
        arguments: weather.place,
      );
    }
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  _scrollListener() {
    // if (_controller.offset >= _controller.position.maxScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   if (_currentWeather != null) _openForecast(weather: _currentWeather);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Setting dark status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context).backgroundColor,
    ));

    return Container(
      decoration: BoxDecoration(color: const Color(0xff000000)),
      child: Stack(
        children: <Widget>[
          Center(
            child: _currentWeather == null ||
                    _currentWeather.weather == null ||
                    _bgImage == null
                ? Image.asset(
                    'assets/images/weather_bg.png',
                    width: safeWidth,
                    height: safeHeight,
                    fit: BoxFit.fill,
                  )
                : CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                        'assets/images/weather_bg.png',
                        fit: BoxFit.fill,
                        gaplessPlayback: true),
                    fadeInDuration: const Duration(seconds: 10),
                    fadeInCurve: Curves.easeInOutSine,
                    imageUrl: _bgImage,
                    fit: BoxFit.fill,
                    width: safeWidth,
                    height: safeHeight,
                  ),
          ),
          Container(
              height: safeHeight,
              width: safeWidth,
              color: AppColors.BACKGROUND_COLOR.withOpacity(0.3)
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Image.asset("assets/images/iconfinder_settings.png"),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.APP_ROUTE_SETTINGS);
                  },
                ),
              ],
            ),
            body: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                _connected = connectivity != ConnectivityResult.none;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      height: ScreenUtil().setHeight(_connected ? 0.0 : 32.0),
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        color:
                            _connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: _connected
                              ? Text('ONLINE')
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('OFFLINE'),
                                    SizedBox(width: 8.0),
                                    SizedBox(
                                      width: 12.0,
                                      height: 12.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: Stack(children: [
                (_trans == null || _trans.isEmpty)
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _emptyMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.w500,
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(40),
                            ),
                            !_isFetching
                                ? SizedBox(
                                    width: ScreenUtil().setWidth(188),
                                    child: ElevatedButton(
                                      child: Text("Add Location",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize:
                                                  ScreenUtil().setSp(18.0)),
                                          textAlign: TextAlign.center),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.PRIMARY_COLOR),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                          context,
                                          AppRoutes.APP_ROUTE_ADD_LOCATIONS),
                                    ),
                                  )
                                : Center(
                                    child: Loading(
                                        indicator:
                                            BallSpinFadeLoaderIndicator(),
                                        size: ScreenUtil().setHeight(48.0),
                                        color: Colors.white),
                                  ),
                          ],
                        ),
                      )
                    : CustomScrollView(
                        controller: _controller,
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    // Rectangle Copy
                                    ///Start alert
                                    _alert != null && _alert.isNotEmpty
                                        ? Opacity(
                                      opacity: 0.9000000357627869,
                                      child: Container(
                                          width: ScreenUtil().setWidth(354),
                                          height: ScreenUtil().setHeight(42),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: Colors.red),
                                          child: Stack(children: [
                                            // ADVISORY: Tropical s
                                            PositionedDirectional(
                                              top: ScreenUtil().setHeight(10),
                                              start: ScreenUtil().setWidth(51),
                                              child: SizedBox(
                                                  width:
                                                  ScreenUtil().setWidth(284),
                                                  height:
                                                  ScreenUtil().setHeight(21),
                                                  child: RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontFamily:
                                                                "HelveticaNeue",
                                                                fontStyle:
                                                                FontStyle.normal,
                                                                fontSize: ScreenUtil()
                                                                    .setSp(13.0)),
                                                            text: "ADVISORY: "),
                                                        TextSpan(
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontFamily:
                                                                "HelveticaNeue",
                                                                fontStyle:
                                                                FontStyle.normal,
                                                                fontSize: ScreenUtil()
                                                                    .setSp(13.0)),
                                                            text:
                                                            _alert[0].description)
                                                      ]))),
                                            ),
                                            PositionedDirectional(
                                              top: ScreenUtil().setHeight(14),
                                              start: ScreenUtil().setWidth(24),
                                              child: SizedBox(
                                                  width:
                                                  ScreenUtil().setWidth(15),
                                                  height:
                                                  ScreenUtil().setHeight(14),
                                                  child: Image.asset(
                                                      "assets/images/exclamation_mark.png")),
                                            )
                                          ])),
                                    )
                                        : SizedBox(),

                                    ///End alert
                                    Center(
                                      child: Text(formattedDate,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.699999988079071),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: ScreenUtil().setSp(14.0)),
                                          textAlign: TextAlign.center),
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(13)),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(424),
                                      //padding: const EdgeInsets.only(left: 20),
                                      child: Swiper(
                                        itemBuilder: (BuildContext context, int index) {
                                          return _buildItem(
                                              physicalScreenSize.width,
                                              _trans[index],
                                              _currentIndex == index);
                                        },
                                        itemCount: _trans.length,
                                        viewportFraction: 0.6,
                                        scale: 0.7,
                                        loop: false,
                                        onIndexChanged: (int index) {
                                          setState(() {
                                            _currentIndex = index;
                                            _currentWeather = _trans[index];
                                            Future.delayed(
                                                const Duration(milliseconds: 500), () {
                                              setState(() {
                                                if (_currentWeather.weather != null)
                                                  _bgImage = _currentWeather
                                                      .weather.background;
                                              });
                                            });
                                          });
                                        },
                                      ),
                                    ),
                                    //_buildTimeItem(context, _hourly[0])
                                  ],
                                ),
                                _currentWeather.weather.hourly != null && _currentWeather.weather.hourly.isNotEmpty ?
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  height: 110,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) => SizedBox(
                                      width: ScreenUtil().setWidth(2),
                                    ),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _currentWeather.weather.hourly.length,
                                    itemBuilder: (context, index) => _buildTimeItem(
                                      context,
                                      _currentWeather.weather.hourly[index],
                                    ),
                                  ),
                                ) :
                                SizedBox(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.APP_ROUTE_SINGLE_WEATHER,
                                      arguments: ScreenArguments2(
                                          _currentWeather.place,
                                          _currentWeather.weather
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/images/more.png"),
                                              SizedBox(
                                                  width: ScreenUtil().setWidth(16)),
                                              Text("MORE DETAILS",
                                                  style: TextStyle(
                                                    fontFamily: 'HelveticaNeue',
                                                    color: Colors.white.withOpacity(0.6),
                                                    fontSize: ScreenUtil().setSp(11),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  ))
                                            ])),
                                  ),
                                ),
                                _currentWeather.weather.history != null && _currentWeather.weather.history.isNotEmpty ?
                                Container(
                                  margin: EdgeInsets.only(left: 36, right: 30),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white.withOpacity(0.13)
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(historyTotal != 0 ? historyTotal : _currentWeather.weather.history.length, (index){
                                      return _buildHistoryItem(
                                        context,
                                        _currentWeather.weather.history[index],
                                      );
                                    }
                                    ),
                                  ),
                                ) :
                                SizedBox(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if(historyTotal == 4)
                                        historyTotal = 0;
                                      else
                                        historyTotal = 4;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/images/more.png"),
                                              SizedBox(
                                                  width: ScreenUtil().setWidth(16)),
                                              Text(historyTotal == 4 ? "MORE": "REDUCE",
                                                  style: TextStyle(
                                                    fontFamily: 'HelveticaNeue',
                                                    color: Colors.white.withOpacity(0.6),
                                                    fontSize: ScreenUtil().setSp(11),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  ))
                                            ])),
                                  ),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (_connected) {
                                          if (_currentWeather != null)
                                            _launchURL("http://wourivice.com/");
                                        } else
                                          Fluttertoast.showToast(
                                              msg: "No connection...");
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: ScreenUtil().setWidth(30.0)),
                                          width: ScreenUtil().setWidth(354),
                                          height: ScreenUtil().setHeight(108),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(6)),
                                              color: Colors.white
                                                  .withOpacity(0.1499999910593033)),
                                          child: Stack(children: [
                                            PositionedDirectional(
                                              top: ScreenUtil().setHeight(21),
                                              start: ScreenUtil().setWidth(37),
                                              child: Opacity(
                                                opacity: 0.6000000238418579,
                                                child: SizedBox(
                                                    width: ScreenUtil().setWidth(98),
                                                    //height: ScreenUtil().setHeight(12),
                                                    child: Text("Wouri’s weekly",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "HelveticaNeue",
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: ScreenUtil()
                                                                .setSp(10.0)))),
                                              ),
                                            ),
                                            // Personal tips and su
                                            PositionedDirectional(
                                              top: ScreenUtil().setHeight(45),
                                              start: ScreenUtil().setWidth(91),
                                              child: SizedBox(
                                                width: ScreenUtil().setWidth(244),
                                                //height: ScreenUtil().setHeight(42),
                                                child: Text(
                                                    "Personal tips and suggestions from celebrity stylist Wouri Vice",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "HelveticaNeue",
                                                        fontStyle: FontStyle.normal,
                                                        fontSize:
                                                        ScreenUtil().setSp(14.0))),
                                              ),
                                            ),
                                            // Oval
                                            PositionedDirectional(
                                              top: ScreenUtil().setHeight(45),
                                              start: ScreenUtil().setWidth(31),
                                              child: Container(
                                                width: ScreenUtil().setWidth(44),
                                                height: ScreenUtil().setHeight(44),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white, width: 2)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(2.0),
                                                  child: Image.asset(
                                                    'assets/images/wouri.png',
                                                    width: 40.0,
                                                    height: 40.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ])),
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(20)),
                                    InkWell(
                                      onTap: () {
                                        if (_connected) {
                                          if (_currentWeather != null)
                                            _openForecast(weather: _currentWeather);
                                        } else
                                          Fluttertoast.showToast(
                                              msg: "No connection...");
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: ScreenUtil().setWidth(30.0)),
                                          height: ScreenUtil().setHeight(20),
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/images/more.png"),
                                                SizedBox(
                                                    width: ScreenUtil().setWidth(16)),
                                                Text("MORE",
                                                    style: TextStyle(
                                                      fontFamily: 'HelveticaNeue',
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil().setSp(10),
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.normal,
                                                    ))
                                              ])),
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(70))
                                  ],
                                )
                              ]
                            )
                          )
                        ],
                      ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      double width, PlaceWithWeather placeWithWeather, bool selected) {
    return Opacity(
      opacity: selected ? 1 : 0.25,
      //width: width - 40,
      child: Builder(builder: (context) {
        return InkWell(
          onTap: () {
            if (_connected) {
              _openForecast(weather: placeWithWeather);
            } else
              Fluttertoast.showToast(msg: "No connection...");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(placeWithWeather.place.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "HelveticaNeue",
                      fontStyle: FontStyle.normal,
                      fontSize: ScreenUtil().setSp(21.0)),
                  textAlign: TextAlign.center),
              SizedBox(
                height: ScreenUtil().setHeight(80),
                child: placeWithWeather.weather != null
                    ? Icon(
                        TempWeather.getWeatherIcon(
                            placeWithWeather.weather.icon),
                        color: AppColors.PRIMARY_COLOR,
                        size: ScreenUtil().setHeight(80),
                      )
                    : SizedBox(),
              ),
              Text(
                  placeWithWeather.weather != null
                      ? placeWithWeather.weather.summery
                      : "",
                  style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w400,
                      fontFamily: "HelveticaNeue",
                      fontStyle: FontStyle.normal,
                      fontSize: ScreenUtil().setSp(15.0)),
                  textAlign: TextAlign.center),
              PreferenceBuilder<bool>(
                  preference: _viewModel.preferences
                      .getBool(AppPreferences.PREF_USE_F, defaultValue: true),
                  builder: (BuildContext context, bool useF) {
                    return Text(
                        placeWithWeather.weather != null
                            ? "${TempWeather.getTemperature(placeWithWeather.weather.temperature, useF)}"
                            : "",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "HelveticaNeue",
                            fontStyle: FontStyle.normal,
                            fontSize: ScreenUtil().setSp(82.0)),
                        textAlign: TextAlign.center);
                  }),
              Text(
                  placeWithWeather.weather != null
                      ? placeWithWeather.weather.description
                      : "",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6000000238418579),
                      fontWeight: FontWeight.w500,
                      fontFamily: "HelveticaNeue",
                      fontStyle: FontStyle.normal,
                      fontSize: ScreenUtil().setSp(17.0)),
                  textAlign: TextAlign.center),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTimeItem(BuildContext context, TempWeather weather) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(70),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: weather.isCurrentHour ? AppColors.PRIMARY_COLOR : AppColors.BACKGROUND_COLOR.withOpacity(0.1)
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Opacity(
                opacity : weather.isCurrentHour ? 1 : 0.5,
                child: SizedBox(
                    width: ScreenUtil().setWidth(38),
                    //height: ScreenUtil().setHeight(28),
                    child: Text(
                        weather.hour,
                        style: TextStyle(
                            color:  weather.isCurrentHour ? AppColors.BACKGROUND_COLOR: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "HelveticaNeue",
                            fontStyle:  FontStyle.normal,
                            fontSize: ScreenUtil().setSp(12.0)
                        ),
                        textAlign: TextAlign.center
                    )
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(8),),
              SizedBox(
                  width: ScreenUtil().setWidth(25),
                  height: ScreenUtil().setHeight(25),
                  child: Icon(
                    TempWeather.getWeatherIcon(weather.icon),
                    color: weather.isCurrentHour ? AppColors.BACKGROUND_COLOR: AppColors.PRIMARY_COLOR,
                    size: ScreenUtil().setHeight(25),
                  )
              ),
              SizedBox(height: ScreenUtil().setHeight(8),),
              SizedBox(
                  height: ScreenUtil().setHeight(27),
                  child: PreferenceBuilder<bool>(
                      preference: _viewModel.preferences.getBool(AppPreferences.PREF_USE_F, defaultValue: true),
                      builder: (BuildContext context, bool useF) {
                        return Text(
                            "${TempWeather.getTemperature(weather.temperature, useF)}",
                            style: TextStyle(
                                color:  weather.isCurrentHour ? AppColors.BACKGROUND_COLOR: Colors.white,
                                fontWeight: weather.isCurrentHour ? FontWeight.w700 : FontWeight.w500,
                                fontFamily: "HelveticaNeue",
                                fontStyle:  FontStyle.normal,
                                fontSize: ScreenUtil().setSp(16.0)
                            ),
                            textAlign: TextAlign.center
                        );
                      }
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, TempWeather weather) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setHeight(8.0)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    TempWeather.getWeatherIcon(weather.icon),
                    color: AppColors.PRIMARY_COLOR,
                    size: ScreenUtil().setHeight(18),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          weather.day,
                          style: TextStyle(
                              color:  Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                              fontFamily: "HelveticaNeue",
                              fontStyle:  FontStyle.normal,
                              fontSize: ScreenUtil().setSp(12.0)
                          ),
                          textAlign: TextAlign.center
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          PreferenceBuilder<bool>(
                              preference: _viewModel.preferences.getBool(AppPreferences.PREF_USE_F, defaultValue: true),
                              builder: (BuildContext context, bool useF) {
                                return Text(
                                    "${TempWeather.getTemperature(weather.temperature, useF)}",
                                    style: TextStyle(
                                        color:  Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: ScreenUtil().setSp(13.0)
                                    ),
                                    textAlign: TextAlign.center
                                );
                              }
                          ),
                          SizedBox(width: 12),
                          Text(
                              "${TempWeather.getWindDirection(weather.windDirection)} ${weather.windSpeed.toInt()} mph",
                              style: TextStyle(
                                  color:  Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: ScreenUtil().setSp(12.0)
                              ),
                              textAlign: TextAlign.center
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                        "Rain",
                        style: TextStyle(
                            color:  Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontFamily: "HelveticaNeue",
                            fontStyle:  FontStyle.normal,
                            fontSize: ScreenUtil().setSp(10.0)
                        ),
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 8),
                    Text(
                        weather != null
                            ? "${(weather.chanceOfRain * 100).toInt()}%"
                            : "",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontFamily: "HelveticaNeue",
                            fontStyle: FontStyle.normal,
                            fontSize:
                            ScreenUtil().setSp(13.0))
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                        "Humidity",
                        style: TextStyle(
                            color:  Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontFamily: "HelveticaNeue",
                            fontStyle:  FontStyle.normal,
                            fontSize: ScreenUtil().setSp(10.0)
                        ),
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 8),
                    Text(
                        weather != null
                            ? "${ weather.humidity.toStringAsFixed(2)}%"
                            : "",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontFamily: "HelveticaNeue",
                            fontStyle: FontStyle.normal,
                            fontSize: ScreenUtil().setSp(13.0))
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveDeviceId() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState.emailSubscribed) {
      var onesignalUserId = deviceState.userId;
      _viewModel.addDevice(onesignalUserId);
    }
  }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  bool positionStreamStarted = false;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    _viewModel.loadPositionWeather(position.latitude, position.longitude);
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      pref.setUseCurrentLocation(hasDevice: false);
      hasLocationPermission = false;
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        hasLocationPermission = false;
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      pref.setUseCurrentLocation(hasDevice: false);
      hasLocationPermission = false;
      return false;
    }

    return true;
  }

  void subscribeToViewModel() {
    _viewModel.getCurrentWeathers().listen((places) {
      _isFetching = false;
      _trans = places;
      if (places != null && places.isNotEmpty) {
        for (int i = 0; i < places.length; i++) {
          if (_selected == null && i == 0) {
            setState(() {
              _currentIndex = i;
              _currentWeather = places[i];
            });
          } else if (_selected == places[i].place.id) {
            setState(() {
              _currentIndex = i;
              _currentWeather = places[i];
            });
          }
        }
        if (_currentWeather != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              if (_currentWeather.weather != null)
                _bgImage = _currentWeather.weather.background;
            });
          });
        }
      }
    });

    _viewModel.isLogout().listen((event) {
      if (event)
        Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_WELCOME);
    });

    _viewModel.getAlerts().listen((alerts) {
      //if(a)
    });

    _viewModel.getEmptyLocation().listen((event) {
      if (event) {
        if(!hasLocationPermission) {
          _isFetching = false;
          setState(() {
            _emptyMessage = "You don't have any saved location";
          });
          Navigator.pushNamed(context, AppRoutes.APP_ROUTE_ADD_LOCATIONS);
        }
      }
    });
  }
}
