import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/models/temp_weather.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/view_models/weekly_forecast_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class WeeklyForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Place args = ModalRoute.of(context).settings.arguments;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.BACKGROUND_COLOR
      ),
      child: _WeeklyForecastView(place: args),
    );
  }
}

class _WeeklyForecastView extends StatefulWidget {
  _WeeklyForecastView({this.place});
  final Place place;
  @override
  State<StatefulWidget> createState() => _WeeklyForecastState();
}

class _WeeklyForecastState extends State<_WeeklyForecastView> {

  WeeklyForecastViewModel _viewModel;
  List<TempWeather> _weathers = [];
  List<String> _suggestions = ["Cold Weather", "Cool Weather", "Hot Weather", "Moderate Weather"];
  ScrollController _controller;
  bool _isloading = true;
  bool _hasError = false;

  @override
  void initState() {
    // Initialize view-model variable
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    _viewModel = WeeklyForecastViewModel(App());
    _isloading = true;
    _viewModel.refreshWeather(widget.place);
    _subscribeToViewModel();

    super.initState();
  }

  @override
  void dispose() {
    _viewModel = null;
    super.dispose();
  }

  _scrollListener() {
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      Navigator.pop(context, false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Forecast",
            style: TextStyle(
              fontFamily: 'HelveticaNeue',
              color: Colors.white,
              fontSize: ScreenUtil().setSp(20),
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            )
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
          child: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      height: ScreenUtil().setHeight(224),
                      width: ScreenUtil.defaultSize.width,
                      child: _isloading ?
                      Center(child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 36.0, color: Colors.white))
                      :
                      _hasError ?
                      Center(
                        child: Text(
                          "Couldn't fetch weather information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w500,
                            fontFamily: "HelveticaNeue",
                            fontStyle:  FontStyle.normal,
                          ),
                        ),
                      )
                      :
                      ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          width: ScreenUtil().setWidth(2),
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _weathers.length,
                        itemBuilder: (context, index) => _buildCarouselItem(
                          context,
                          _weathers[index],
                        ),
                      ),
                    ),
                    // SizedBox(height: ScreenUtil().setHeight(26)),
                    // Container(
                    //     width: ScreenUtil().setWidth(354),
                    //     height: ScreenUtil().setHeight(205),
                    //     padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                    //     decoration: new BoxDecoration(
                    //         color: Colors.white.withOpacity(0.1499999910593033),
                    //         borderRadius: BorderRadius.circular(4)
                    //     ),
                    //   child: Stack(
                    //     children: <Widget>[
                    //       PositionedDirectional(
                    //         start: 0,
                    //         top: 0,
                    //         child: SizedBox(
                    //             width: ScreenUtil().setWidth(130),
                    //             height: ScreenUtil().setHeight(130),
                    //             child: CachedNetworkImage(
                    //               placeholder: (context, url) =>
                    //                 Center(
                    //                   child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 36.0, color: AppColors.PRIMARY_COLOR)
                    //               ),
                    //               imageUrl: _highligted != null ? _highligted.thumbnail : "",
                    //               fit: BoxFit.fitHeight,
                    //             ),
                    //         ),
                    //       ),
                    //       PositionedDirectional(
                    //         start: 0,
                    //         bottom: 0,
                    //         child: SizedBox(
                    //             width: ScreenUtil().setWidth(130),
                    //             height: ScreenUtil().setHeight(35),
                    //             child:  RaisedButton(
                    //               child: Text(
                    //                   "Buy now",
                    //                   style: TextStyle(
                    //                       color:  Colors.black,
                    //                       fontWeight: FontWeight.w700,
                    //                       fontFamily: "HelveticaNeue",
                    //                       fontStyle:  FontStyle.normal,
                    //                       fontSize: ScreenUtil().setSp(12.0)
                    //                   ),
                    //                   textAlign: TextAlign.center
                    //               ),
                    //               onPressed: _highligted != null
                    //                   ?
                    //                   () {
                    //                 _launchURL(context, _highligted.url);
                    //               }
                    //                   :
                    //               null,
                    //             )
                    //         ),
                    //       ),
                    //       PositionedDirectional(
                    //         top: ScreenUtil().setHeight(31),
                    //         end: ScreenUtil().setWidth(7),
                    //         child:
                    //         SizedBox(
                    //             width: ScreenUtil().setWidth(161),
                    //             height: ScreenUtil().setHeight(136),
                    //             child:   Text(
                    //                 _highligted != null ? _highligted.description : "",
                    //                 style: TextStyle(
                    //                     color:  Colors.white,
                    //                     fontWeight: FontWeight.w400,
                    //                     fontFamily: "HelveticaNeue",
                    //                     fontStyle:  FontStyle.normal,
                    //                     fontSize: ScreenUtil().setSp(13.0
                    //                 )
                    //               )
                    //             ),
                    //         ),
                    //       ),
                    //       PositionedDirectional(
                    //         top: ScreenUtil().setHeight(3),
                    //         start: ScreenUtil().setSp(156),
                    //         child:
                    //         SizedBox(
                    //             //width: ScreenUtil().setWidth(49),
                    //             height: ScreenUtil().setHeight(21),
                    //             child:   Text(
                    //                 _highligted != null ? _highligted.title : "Today",
                    //                 style: TextStyle(
                    //                     color:  AppColors.PRIMARY_COLOR,
                    //                     fontWeight: FontWeight.w700,
                    //                     fontFamily: "HelveticaNeue",
                    //                     fontStyle:  FontStyle.normal,
                    //                     fontSize: ScreenUtil().setSp(11.0)
                    //                 )
                    //             )
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 26),
                    Row(
                      children: <Widget>[
                        Text("Wouri's Weekly fashion picks",
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              color: Color(0xffffffff),
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                            )
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(16.0)),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return _suggestionListItem(_suggestions[index]);
                  },
                  childCount: _suggestions.length,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(80.0)),
              )
            ],
          )
        ),
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, TempWeather weather) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          AppRoutes.APP_ROUTE_SINGLE_WEATHER,
          arguments: ScreenArguments2(
              widget.place,
              weather
          ),
        );
      },
      child: Container(
          width: ScreenUtil().setWidth(83),
          height: ScreenUtil().setHeight(224),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(4)
              ),
              color: weather.isToday ? AppColors.PRIMARY_COLOR : AppColors.BACKGROUND_COLOR
          ),
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setHeight(8.0)),
          child: Column(
            children: <Widget>[
              Opacity(
                opacity : weather.isToday ? 1 : 0.5,
                child: SizedBox(
                  width: ScreenUtil().setWidth(38),
                  //height: ScreenUtil().setHeight(28),
                  child: Text(
                    weather.day,
                    style: TextStyle(
                      color:  weather.isToday ? AppColors.BACKGROUND_COLOR: Colors.white,
                      fontWeight: weather.isToday ? FontWeight.w700 : FontWeight.w400,
                      fontFamily: "HelveticaNeue",
                      fontStyle:  FontStyle.normal,
                      fontSize: ScreenUtil().setSp(11.0)
                    ),
                    textAlign: TextAlign.center
                  )
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(15),),
              SizedBox(
                  width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setHeight(40),
                  child: Icon(
                    TempWeather.getWeatherIcon(weather.icon),
                    color: weather.isToday ? AppColors.BACKGROUND_COLOR: AppColors.PRIMARY_COLOR,
                    size: ScreenUtil().setHeight(40),
                  )
              ),
              SizedBox(height: ScreenUtil().setHeight(12),),
              Opacity(
                opacity : weather.isToday ? 1 : 0.30000001192092896,
                child:   SizedBox(
                    width: ScreenUtil().setWidth(29),
                    //height: ScreenUtil().setWidth(12),
                    child:   Text(
                        "High",
                        style: TextStyle(
                            color:  weather.isToday ? AppColors.BACKGROUND_COLOR: Colors.white,
                            fontWeight: weather.isToday ? FontWeight.w500 : FontWeight.w400,
                            fontFamily: "HelveticaNeue",
                            fontStyle:  FontStyle.normal,
                            fontSize: ScreenUtil().setSp(10.0),
                          //letterSpacing: 0.9,

                        ),
                        textAlign: TextAlign.center
                    )
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5),),
              Opacity(
                opacity : weather.isToday ? 1 : 0.5,
                child:   SizedBox(
                    //width: ScreenUtil().setWidth(22),
                    height: ScreenUtil().setHeight(27),
                    child: PreferenceBuilder<bool>(
                        preference: _viewModel.preferences.getBool(AppPreferences.PREF_USE_F, defaultValue: true),
                        builder: (BuildContext context, bool useF) {
                          return Text(
                              "${weather.getMaxTemperature(useF)}",
                              style: TextStyle(
                                  color:  weather.isToday ? AppColors.BACKGROUND_COLOR: Colors.white,
                                  fontWeight: weather.isToday ? FontWeight.w700 : FontWeight.w500,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: ScreenUtil().setSp(22.0)
                              ),
                              textAlign: TextAlign.center
                          );
                        }
                    )
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(7),),
              Opacity(
                opacity : 0.4000000059604645,
                child:   Container(
                    width: ScreenUtil().setWidth(59),
                    height: ScreenUtil().setHeight(1),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: weather.isToday ? AppColors.BACKGROUND_COLOR: const Color(0xff000205),
                            width: ScreenUtil().setWidth(1)
                        )
                    )
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(12),),
              Opacity(
                opacity : weather.isToday ? 1 : 0.30000001192092896,
                child:   SizedBox(
                    width: ScreenUtil().setWidth(29),
                    //height: ScreenUtil().setWidth(12),
                    child:   Text(
                        "Low",
                        style: TextStyle(
                          color:  weather.isToday ? AppColors.BACKGROUND_COLOR: Colors.white,
                          fontWeight: weather.isToday ? FontWeight.w500 : FontWeight.w400,
                          fontFamily: "HelveticaNeue",
                          fontStyle:  FontStyle.normal,
                          fontSize: ScreenUtil().setSp(10.0),
                          //letterSpacing: 0.9,

                        ),
                        textAlign: TextAlign.center
                    )
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5),),
              Opacity(
                opacity : weather.isToday ? 1 : 0.5,
                child:   SizedBox(
                  //width: ScreenUtil().setWidth(22),
                    height: ScreenUtil().setHeight(27),
                    child: PreferenceBuilder<bool>(
                        preference: _viewModel.preferences.getBool(AppPreferences.PREF_USE_F, defaultValue: true),
                        builder: (BuildContext context, bool useF) {
                          return Text(
                              "${weather.getMinTemperature(useF)}",
                              style: TextStyle(
                                  color:  weather.isToday ? AppColors.BACKGROUND_COLOR: Colors.white,
                                  fontWeight: weather.isToday ? FontWeight.w700 : FontWeight.w500,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: ScreenUtil().setSp(22.0)
                              ),
                              textAlign: TextAlign.center
                          );
                        }
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _subscribeToViewModel() {
    _viewModel.getWeathers().listen((weathers){
      _isloading = false;
      if(weathers != null && weathers.weather.isNotEmpty) {
        setState(() {
          _weathers = weathers.weather;
        });
      }
    });
    _viewModel.getError().listen((event) {
      setState(() {
        _isloading = false;
        _hasError = event;
      });
    });
  }

  String _getImage(String s){
    switch(s){
      case "Cold Weather":
        return "assets/images/cold-weather-icon.png";
      case "Cool Weather":
        return "assets/images/cool-weather-icon.png";
      case "Hot Weather":
        return "assets/images/hot-weather-icon.png";
      default:
        return "assets/images/modrate-weather-cion.png";
    }
  }

  String _getCondition(String s){
    switch(s){
      case "Cold Weather":
        return "cold";
      case "Cool Weather":
        return "cool";
      case "Hot Weather":
        return "hot";
      default:
        return "moderate";
    }
  }

  Widget _suggestionListItem(String item) {
    return new GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.APP_ROUTE_WEEKLY_SUGGESTION,
            arguments: ScreenArguments(
              widget.place,
              _getCondition(item),
              _weathers
            ),
          );
        },
        child: Container(
          width: ScreenUtil().setWidth(174),
          height: ScreenUtil().setHeight(164),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Color(0xffd8d8d8)
              ),
            borderRadius: BorderRadius.all(
                Radius.circular(4.0) //                 <--- border radius here
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image(image: AssetImage(_getImage(item))),
                ),
                Text(
                    item,
                    style: TextStyle(
                        color:  AppColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.w500,
                        fontFamily: "HelveticaNeue",
                        fontStyle:  FontStyle.normal,
                        fontSize: ScreenUtil().setSp(14.0)
                    ),
                    textAlign: TextAlign.center
                ),
              ],
            ),
          ),
        )
    );
  }
}

class ScreenArguments {
  final Place place;
  final String condition;
  final List<TempWeather> weathers;

  ScreenArguments(this.place, this.condition, this.weathers);
}

class ScreenArguments2 {
  final Place place;
  final TempWeather weather;

  ScreenArguments2(this.place, this.weather);
}