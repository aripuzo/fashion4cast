import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class Complete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      theme: AppStyles.defaultTheme(),
      home: _CompleteView(args: args),
      onGenerateRoute: App().getAppRoutes().getRoutes,
    );
  }
}

class _CompleteView extends StatefulWidget {
  _CompleteView({this.args});
  final ScreenArguments args;
  @override
  State<StatefulWidget> createState() => _CompleteState();
}

class _CompleteState extends State<_CompleteView> {
  @override
  void initState() {
    super.initState();
    pref = App().getAppPreferences();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColors.BACKGROUND_COLOR,
    ));

    return Container(
      decoration: BoxDecoration(
          color: AppColors.BACKGROUND_COLOR
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/check.png"),
                    width: ScreenUtil().setWidth(84),
                    height: ScreenUtil().setHeight(84),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(277),
                      //height: 64,
                      child:   Text(
                          widget.args.message,
                          style: TextStyle(
                              color:  Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "HelveticaNeue",
                              fontStyle:  FontStyle.normal,
                              fontSize: ScreenUtil().setSp(20.0)
                          ),
                          textAlign: TextAlign.center
                      )
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(86),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(188),
                      child:  ElevatedButton(
                        child: Text(
                            "Continue",
                            style: TextStyle(
                                color:  Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: "HelveticaNeue",
                                fontStyle:  FontStyle.normal,
                                fontSize: ScreenUtil().setSp(18.0)
                            ),
                            textAlign: TextAlign.center
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.PRIMARY_COLOR),
                        ),
                        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(widget.args.message, (Route<dynamic> route) => false)
                      )
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  bool positionStreamStarted = false;
  AppPreferences pref;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    Navigator.of(context).pushNamedAndRemoveUntil(widget.args.message, (Route<dynamic> route) => false);
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      pref.setUseCurrentLocation(hasDevice: false);
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      pref.setUseCurrentLocation(hasDevice: false);
      return false;
    }

    return true;
  }
}

class ScreenArguments {
  final String message;
  final String route;

  ScreenArguments(this.message, this.route);
}