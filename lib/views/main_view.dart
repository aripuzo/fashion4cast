import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/databases/dao/current_weather_dao.dart';
import 'package:fashion4cast/models/alert.dart';
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
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

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

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    _viewModel = MainViewModel(App());
    subscribeToViewModel();

    pref = App().getAppPreferences();

    _selected = pref.getDefaultPlace();

    _viewModel.refreshWeather();

    var now = new DateTime.now();
    formattedDate = "Today, ${DateFormat('EEEE d MMMM').format(now)}";

    if(!pref.hasDevice())
      _saveDeviceId();

    super.initState();
  }

  _openForecast({@required PlaceWithWeather weather}){
    if(_connected) {
      Navigator.pushNamed(
        context,
        AppRoutes.APP_ROUTE_WEEKLY_FORECAST,
        arguments: weather.place,
      );
    }
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if(_currentWeather != null)
        _openForecast(weather: _currentWeather);
    }
  }

  @override
  Widget build(BuildContext context) {

    // Setting dark status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context)
          .backgroundColor,
    ));

    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff000000)
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: _currentWeather == null || _currentWeather.weather == null || _bgImage == null ?
            Image.asset(
              'assets/images/weather_bg.png',
              width: ScreenUtil.defaultSize.width,
              height: ScreenUtil.defaultSize.height,
              fit: BoxFit.fill,
            )
                :
            CachedNetworkImage(
              placeholder: (context, url) => Image.asset(
                'assets/images/weather_bg.png',
                fit: BoxFit.fill,
                gaplessPlayback: true
              ),
              fadeInDuration: const Duration(seconds: 10),
              fadeInCurve: Curves.easeInOutSine,
              imageUrl: _bgImage,
              fit: BoxFit.fill,
              width: ScreenUtil.defaultSize.width,
              height: ScreenUtil.defaultSize.height,
            ),
          ),
          Container(
              height: ScreenUtil.defaultSize.height,
              width: ScreenUtil.defaultSize.width,
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
                        color: _connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
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
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                (_trans == null || _trans.isEmpty) ?
                Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
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
                          fontStyle:  FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(40),),
                      !_isFetching ?
                      SizedBox(
                        width: ScreenUtil().setWidth(188),
                        child: RaisedButton(
                          child: Text(
                              "Add Location",
                              style: TextStyle(
                                  color:  Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: ScreenUtil().setSp(18.0)
                              ),
                              textAlign: TextAlign.center
                          ),
                          animationDuration: Duration(seconds: 2),
                          onPressed: () => Navigator.pushNamed(context, AppRoutes.APP_ROUTE_ADD_LOCATIONS),
                        ),
                      )
                          :
                      Center(
                        child: Loading(
                            indicator: BallSpinFadeLoaderIndicator(),
                            size: ScreenUtil().setHeight(48.0), color: Colors.white
                        ),
                      ),
                    ],
                  ),
                )
                    :
                SingleChildScrollView(
                  //padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
                  controller: _controller,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Rectangle Copy
                      ///Start alert
                      _alert != null && _alert.isNotEmpty ?
                      Opacity(
                        opacity : 0.9000000357627869,
                        child: Container(
                            width: ScreenUtil().setWidth(354),
                            height: ScreenUtil().setHeight(42),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)
                                ),
                                color: Colors.red
                            ),
                            child: Stack(children: [
                              // ADVISORY: Tropical s
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(10),
                                start: ScreenUtil().setWidth(51),
                                child:
                                SizedBox(
                                    width: ScreenUtil().setWidth(284),
                                    height: ScreenUtil().setHeight(21),
                                    child:   RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  style: TextStyle(
                                                      color:  Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "HelveticaNeue",
                                                      fontStyle:  FontStyle.normal,
                                                      fontSize: ScreenUtil().setSp(13.0)
                                                  ),
                                                  text: "ADVISORY: "),
                                              TextSpan(
                                                  style: TextStyle(
                                                      color:  Colors.white,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "HelveticaNeue",
                                                      fontStyle:  FontStyle.normal,
                                                      fontSize: ScreenUtil().setSp(13.0)
                                                  ),
                                                  text: _alert[0].description)
                                            ]
                                        )
                                    )
                                ),
                              ),
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(14),
                                start: ScreenUtil().setWidth(24),
                                child:
                                SizedBox(
                                    width: ScreenUtil().setWidth(15),
                                    height: ScreenUtil().setHeight(14),
                                    child:   Image.asset("assets/images/exclamation_mark.png")
                                ),
                              )
                            ])
                        ),
                      )
                          :
                      SizedBox()
                      ,
                      ///End alert
                      Center(
                        child: Text(
                            formattedDate,
                            style: TextStyle(
                                color:  Colors.white.withOpacity(0.699999988079071),
                                fontWeight: FontWeight.w400,
                                fontFamily: "HelveticaNeue",
                                fontStyle:  FontStyle.normal,
                                fontSize: ScreenUtil().setSp(14.0)
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(13)),
                      SizedBox(
                        height: ScreenUtil().setHeight(424),
                        //padding: const EdgeInsets.only(left: 20),
                        child: Swiper(
                          itemBuilder: (BuildContext context,int index){
                            return _buildItem(ScreenUtil.defaultSize.width, _trans[index], _currentIndex == index);
                          },
                          itemCount: _trans.length,
                          viewportFraction: 0.6,
                          scale: 0.7,
                          loop: false,
                          onIndexChanged: (int index) {
                            setState(() {
                              _currentIndex = index;
                              _currentWeather = _trans[index];
                              Future.delayed(const Duration(milliseconds: 500), () {
                                setState(() {
                                  if(_currentWeather.weather != null)
                                    _bgImage = _currentWeather.weather.background;
                                });
                              });
                            });
                          },
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(13)),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
                        width: ScreenUtil().setWidth(354),
                        height: ScreenUtil().setHeight(177),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(6)
                            ),
                            color: Colors.white.withOpacity(0.1499999910593033)
                        ),
                        child: Stack(
                            children: [
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(27),
                                start: ScreenUtil().setWidth(31),
                                child:
                                SizedBox(
                                    width: ScreenUtil().setWidth(97),
                                    height: ScreenUtil().setHeight(12),
                                    child:   Text(
                                        "Chance of Rain",
                                        style: TextStyle(
                                            color:  Colors.white.withOpacity(0.6000000238418579),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(10.0)
                                        )
                                    )
                                ),
                              ),
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(105),
                                start: ScreenUtil().setWidth(31),
                                child:
                                SizedBox(
                                    width: ScreenUtil().setWidth(60),
                                    //height: ScreenUtil().setHeight(12),
                                    child:   Text(
                                        "Pressure",
                                        style: TextStyle(
                                            color:  Colors.white.withOpacity(0.6000000238418579),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(10.0)
                                        )
                                    )
                                ),
                              ),
                              // Humidity
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(27),
                                start: ScreenUtil().setWidth(200),
                                child:
                                SizedBox(
                                    width: ScreenUtil().setWidth(55),
                                    //height: ScreenUtil().setHeight(12),
                                    child:   Text(
                                        "Humidity",
                                        style: TextStyle(
                                            color:  Colors.white.withOpacity(0.6000000238418579),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(10.0)
                                        )
                                    )
                                ),
                              ),
                              // Wind
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(105),
                                start: ScreenUtil().setWidth(200),
                                child:
                                SizedBox(
                                    width: ScreenUtil().setWidth(30),
                                    //height: ScreenUtil().setHeight(12),
                                    child:   Text(
                                        "Wind",
                                        style: TextStyle(
                                            color:  Colors.white.withOpacity(0.6000000238418579),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(10.0)
                                        )
                                    )
                                ),
                              ),
                              // 74%
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(44),
                                start: ScreenUtil().setWidth(31),
                                child:
                                SizedBox(
                                  //width: ScreenUtil().setWidth(49),
                                  //height: ScreenUtil().setHeight(27),
                                    child:   Text(
                                        _currentWeather.weather != null ? "${(_currentWeather.weather.chance_of_rain * 100).toInt()}%" : "",
                                        style: TextStyle(
                                            color:  Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(23.0)
                                        )
                                    )
                                ),
                              ),
                              // 29.84 in
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(122),
                                start: ScreenUtil().setWidth(51),
                                child: SizedBox(
                                  //width: ScreenUtil().setWidth(83),
                                  //height: ScreenUtil().setHeight(27),
                                    child:   Text(
                                        _currentWeather.weather != null ? "${_currentWeather.weather.pressure} in" : "",
                                        style: TextStyle(
                                            color:  Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(23.0)
                                        )
                                    )
                                ),
                              ),
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(127),
                                start: ScreenUtil().setWidth(31),
                                child: SizedBox(
                                    width: ScreenUtil().setWidth(14),
                                    height: ScreenUtil().setHeight(19),
                                    child: Image.asset(_currentWeather.weather != null ? TempWeather.getArrow(_currentWeather.weather.pressure, _currentWeather.weather.pressure_daily) : "assets/images/arrow_red.png")
                                ),
                              ),
                              // 93%
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(44),
                                start: ScreenUtil().setWidth(200),
                                child:
                                SizedBox(
                                  //width: 49,
                                  //height: ScreenUtil().setHeight(27),
                                    child:   Text(
                                        _currentWeather.weather != null ? "${_currentWeather.weather.humidity.toStringAsFixed(2)}%" : "",
                                        style: TextStyle(
                                            color:  Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(23.0)
                                        )
                                    )
                                ),
                              ),
                              // SSW 2 mph
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(122),
                                start: ScreenUtil().setWidth(200),
                                child: SizedBox(
                                  //width: 125,
                                  //height: ScreenUtil().setHeight(29),
                                    child:   Text(
                                        _currentWeather.weather != null ? "${TempWeather.getWindDirection(_currentWeather.weather.wind_direction)} ${_currentWeather.weather.wind_speed.toInt()} mph" : "",
                                        style: TextStyle(
                                            color:  Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(22.0)
                                        )
                                    )
                                ),
                              ),
                              // Line
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(86),
                                start: ScreenUtil().setWidth(20),
                                child:
                                Opacity(
                                  opacity : 0.2000000029802322,
                                  child:   Container(
                                      width: ScreenUtil().setWidth(144),
                                      height: ScreenUtil().setHeight(2),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffffffff),
                                              width: 1
                                          )
                                      )
                                  ),
                                ),
                              ),
                              // Line Copy 3
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(86),
                                start: ScreenUtil().setWidth(188),
                                child:
                                Opacity(
                                  opacity : 0.2000000029802322,
                                  child:   Container(
                                      width: ScreenUtil().setWidth(144),
                                      height: ScreenUtil().setHeight(2),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffffffff),
                                              width: 1
                                          )
                                      )
                                  ),
                                ),
                              ),
                              // Line 2
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(21),
                                start: ScreenUtil().setWidth(174),
                                child:
                                Opacity(
                                  opacity : 0.2000000029802322,
                                  child:   Container(
                                      width: ScreenUtil().setWidth(1),
                                      height: ScreenUtil().setHeight(60),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffffffff),
                                              width: 1
                                          )
                                      )
                                  ),
                                ),
                              ),
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(94),
                                start: ScreenUtil().setWidth(174),
                                child:
                                Opacity(
                                  opacity : 0.2000000029802322,
                                  child:   Container(
                                      width: ScreenUtil().setWidth(1),
                                      height: ScreenUtil().setHeight(60),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffffffff),
                                              width: 1
                                          )
                                      )
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(13)),
                      InkWell(
                        onTap: () {
                          if(_connected) {
                            if (_currentWeather != null)
                              _openForecast(weather: _currentWeather);
                          }
                          else
                            Fluttertoast.showToast(msg: "No connection...");
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
                            width: ScreenUtil().setWidth(354),
                            height: ScreenUtil().setHeight(108),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(6)
                                ),
                                color: Colors.white.withOpacity(0.1499999910593033)
                            ),
                            child: Stack(children: [
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(21),
                                start: ScreenUtil().setWidth(37),
                                child:
                                Opacity(
                                  opacity : 0.6000000238418579,
                                  child:   SizedBox(
                                      width: ScreenUtil().setWidth(98),
                                      //height: ScreenUtil().setHeight(12),
                                      child:   Text(
                                          "Wouri’s weekly",
                                          style: TextStyle(
                                              color:  Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: ScreenUtil().setSp(10.0)
                                          )
                                      )
                                  ),
                                ),
                              ),
                              // Personal tips and su
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(45),
                                start: ScreenUtil().setWidth(91),
                                child:
                                SizedBox(
                                    width: ScreenUtil().setWidth(244),
                                    //height: ScreenUtil().setHeight(42),
                                    child: Text(
                                        "Personal tips and suggestions from celebrity stylist Wouri Vice",
                                        style: TextStyle(
                                            color:  Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(14.0)
                                        )
                                    ),
                                ),
                              ),
                              // Oval
                              PositionedDirectional(
                                top: ScreenUtil().setHeight(45),
                                start: ScreenUtil().setWidth(31),
                                child:
                                Container(
                                    width: ScreenUtil().setWidth(44),
                                    height: ScreenUtil().setHeight(44),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 2
                                        )
                                    ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2.0),
                                    child: Image.asset(
                                      'assets/images/wouri.png',
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ])
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      InkWell(
                        onTap: () {
                          if(_connected) {
                            if (_currentWeather != null)
                              _openForecast(weather: _currentWeather);
                          }
                          else
                            Fluttertoast.showToast(msg: "No connection...");
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
                            height: ScreenUtil().setHeight(20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/more.png"),
                                  SizedBox(width: ScreenUtil().setWidth(16)),
                                  Text("MORE",
                                      style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(10),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )
                                  )
                                ])
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(70))
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(double width, PlaceWithWeather placeWithWeather, bool selected) {
    return Opacity(
      opacity : selected ? 1 : 0.25,
      //width: width - 40,
      child: Builder(builder: (context) {
        return InkWell(
          onTap: () {
            if(_connected) {
              _openForecast(weather: placeWithWeather);
            }
            else
              Fluttertoast.showToast(msg: "No connection...");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                  placeWithWeather.place.name,
                  style: TextStyle(
                      color:  Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "HelveticaNeue",
                      fontStyle:  FontStyle.normal,
                      fontSize: ScreenUtil().setSp(24.0)
                  ),
                  textAlign: TextAlign.center
              ),
              SizedBox(
                height: ScreenUtil().setHeight(109),
                child: placeWithWeather.weather != null ?
                Icon(
                  TempWeather.getWeatherIcon(placeWithWeather.weather.icon),
                  color: AppColors.PRIMARY_COLOR,
                  size: ScreenUtil().setHeight(109),
                )
                :
                SizedBox(),
              ),
              SizedBox(height: ScreenUtil().setHeight(20),),
              Text(
                  placeWithWeather.weather != null ? placeWithWeather.weather.summery : "",
                  style: TextStyle(
                      color:  AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w400,
                      fontFamily: "HelveticaNeue",
                      fontStyle:  FontStyle.normal,
                      fontSize: ScreenUtil().setSp(15.0)
                  ),
                  textAlign: TextAlign.center
              ),
              PreferenceBuilder<bool>(
                preference: _viewModel.preferences.getBool(AppPreferences.PREF_USE_F, defaultValue: true),
                builder: (BuildContext context, bool useF) {
                  return Text(
                      placeWithWeather.weather != null ?  "${TempWeather.getTemperature(placeWithWeather.weather.temperature, useF)}" : "",
                      style: TextStyle(
                          color:  Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "HelveticaNeue",
                          fontStyle:  FontStyle.normal,
                          fontSize: ScreenUtil().setSp(100.0)
                      ),
                      textAlign: TextAlign.center
                  );
                }
              ),
              SizedBox(
                  width: ScreenUtil().setWidth(272),
                  child: Text(
                      placeWithWeather.weather != null ? placeWithWeather.weather.description : "",
                      style: TextStyle(
                          color:  Colors.white.withOpacity(0.6000000238418579),
                          fontWeight: FontWeight.w500,
                          fontFamily: "HelveticaNeue",
                          fontStyle:  FontStyle.normal,
                          fontSize: ScreenUtil().setSp(17.0)
                      ),
                      textAlign: TextAlign.center
                  )
              ),
            ],
          ),
        );
      }),
    );
  }

  _saveDeviceId() async{
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState.emailSubscribed) {
      var onesignalUserId = deviceState.userId;
      _viewModel.addDevice(onesignalUserId);
    }

  }

//  _getCurrentLocation() {
//    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//    geolocator
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//        .then((Position position) {
//      setState(() {
//        //_currentPosition = position;
//      });
//    }).catchError((e) {
//      print(e);
//    });
//  }

  void subscribeToViewModel() {
    _viewModel.getCurrentWeathers()
        .listen((places){
          _isFetching = false;
          _trans = places;
          if(places != null && places.isNotEmpty) {
            for(int i = 0; i < places.length; i++){
              if(_selected == null && i == 0){
                setState(() {
                  _currentIndex = i;
                  _currentWeather = places[i];
                });
              }
              else if(_selected == places[i].place.id) {
                setState(() {
                  _currentIndex = i;
                  _currentWeather = places[i];
                });
              }
            }
            if(_currentWeather != null){
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  if(_currentWeather.weather != null)
                    _bgImage = _currentWeather.weather.background;
                });
              });
            }
          }
        });

    _viewModel.isLogout().listen((event) {
      if(event)
        Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_WELCOME);
    });

    _viewModel.getAlerts().listen((alerts) {
      //if(a)
    });

    _viewModel.getEmptyLocation().listen((event) {
      if(event) {
        setState(() {
          _isFetching = false;
          _emptyMessage = "You don't have any saved location";
        });
        Navigator.pushNamed(
            context, AppRoutes.APP_ROUTE_ADD_LOCATIONS);
      }
    });
  }
}