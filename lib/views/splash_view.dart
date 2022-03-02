import 'dart:async';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_styles.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(designSize: Size(), allowFontScaling: true);
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => MaterialApp(
          theme: AppStyles.defaultTheme(),
          debugShowCheckedModeBanner: false,
          home: SplashView(),
          onGenerateRoute: AppRoutes().getRoutes,
        ),
    );
  }
}

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  var _iconAnimationController;
  var _iconAnimation;

  startTimeout() async {
    return Timer(const Duration(seconds: 3), handleTimeout);
  }

  void handleTimeout()async {

    await App().getAppPreferences().isPreferenceReady;
//
    var pref = App().getAppPreferences();

    if(pref.isLoggedIn())
      Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_MAIN);
    else
      Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_WELCOME);
  }

  @override
  void initState() {
    super.initState();

    _iconAnimationController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);

    _iconAnimation = CurvedAnimation(parent: _iconAnimationController, curve: Curves.fastOutSlowIn);
    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();

    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BACKGROUND_COLOR,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Center(
              child: Text(
                  "Fashion4Cast",
                  style: logoStyle,
                  textAlign: TextAlign.center
              ),
            ),
            Positioned(
              top: ScreenUtil().setHeight(825),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 24.0, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}