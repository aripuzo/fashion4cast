import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/alert.dart';
import 'package:fashion4cast/models/temp_weather.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/view_models/single_weather_viewmodel.dart';
import 'package:fashion4cast/views/weekly_forecast_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SingleWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments2 args = ModalRoute.of(context).settings.arguments;
    return Container(
      child: _SingleWeatherView(args: args),
    );
  }
}

class _SingleWeatherView extends StatefulWidget {
  final ScreenArguments2 args;
  _SingleWeatherView({this.args});
  @override
  State<StatefulWidget> createState() => _SingleWeatherState();
}

class _SingleWeatherState extends State<_SingleWeatherView> {

  SingleWeatherViewModel _viewModel;
  StreamingSharedPreferences preferences;

  List<Alert> _alert = [];

  String formattedDate;

  AppPreferences pref;

  String _bgImage;

  var safeWidth;

  var safeHeight;

  var physicalScreenSize = window.physicalSize;

  @override
  void initState() {

    _viewModel = SingleWeatherViewModel(App());
    subscribeToViewModel();
    StreamingSharedPreferences.instance.then((value) {
      setState(() {
        preferences = value;
      });
    });

    formattedDate = widget.args.weather.date;

    _bgImage = widget.args.weather.background;

    var logicalScreenSize = window.physicalSize / window.devicePixelRatio;

    var paddingLeft = window.padding.left / window.devicePixelRatio;
    var paddingRight = window.padding.right / window.devicePixelRatio;
    var paddingTop = window.padding.top / window.devicePixelRatio;
    var paddingBottom = window.padding.bottom / window.devicePixelRatio;

//Safe area in logical pixels
    safeWidth = logicalScreenSize.width - paddingLeft - paddingRight;
    safeHeight = logicalScreenSize.height - paddingTop - paddingBottom;

    super.initState();
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
            child: widget.args.weather == null || widget.args.weather == null || _bgImage == null ?
            Image.asset(
              'assets/images/weather_bg.png',
              width: safeWidth,
              height: safeHeight,
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
              width: safeWidth,
              height: safeHeight,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:() => Navigator.pop(context, false),
              ),
            ),
            body: Stack(children: [
              SingleChildScrollView(
                // controller: _controller,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                              widget.args.place.name,
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
                            child: widget.args.weather != null ?
                            Icon(
                              TempWeather.getWeatherIcon(widget.args.weather.icon),
                              color: AppColors.PRIMARY_COLOR,
                              size: ScreenUtil().setHeight(109),
                            )
                                :
                            SizedBox(),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20),),
                          Text(
                              widget.args.weather != null ? widget.args.weather.summery : "",
                              style: TextStyle(
                                  color:  AppColors.PRIMARY_COLOR,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: ScreenUtil().setSp(15.0)
                              ),
                              textAlign: TextAlign.center
                          ),
                          preferences != null ?
                          PreferenceBuilder<bool>(
                              preference: preferences.getBool(AppPreferences.PREF_USE_F, defaultValue: true),
                              builder: (BuildContext context, bool useF) {
                                return Text(
                                    widget.args.weather != null ?  "${TempWeather.getTemperature(widget.args.weather.temperature, useF)}" : "",
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
                          ):
                          Text(
                              widget.args.weather != null ?  "${widget.args.weather.temperature}" : "",
                              style: TextStyle(
                                  color:  Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: ScreenUtil().setSp(100.0)
                              ),
                              textAlign: TextAlign.center
                          ),
                          SizedBox(
                              width: ScreenUtil().setWidth(272),
                              child: Text(
                                  widget.args.weather != null ? widget.args.weather.description : "",
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
                                  child:   Text(
                                      widget.args.weather != null ? "${(widget.args.weather.chanceOfRain).toInt()}%" : "",
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
                                      widget.args.weather != null ? "${widget.args.weather.pressure} in" : "",
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
                                  child: Image.asset(widget.args.weather != null ? TempWeather.getArrow(widget.args.weather.pressure, widget.args.weather.pressureDaily) : "assets/images/arrow_red.png")
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
                                      widget.args.weather != null ? "${widget.args.weather.humidity.toStringAsFixed(2)}%" : "",
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
                                      widget.args.weather != null ? "${TempWeather.getWindDirection(widget.args.weather.windDirection)} ${widget.args.weather.windSpeed.toInt()} mph" : "",
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
                            // Line 2 Copy
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
                    Container(
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
                    SizedBox(height: ScreenUtil().setHeight(70))
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void subscribeToViewModel() {
    _viewModel.getCurrentWeathers()
        .listen((places){
        });
  }
}