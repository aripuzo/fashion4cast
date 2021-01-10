import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_styles.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppStyles.defaultTheme(),
      debugShowCheckedModeBanner: false,
      home: _WelcomeView(),
      onGenerateRoute: App().getAppRoutes().getRoutes,
    );
  }
}

class _WelcomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<_WelcomeView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context)
          .backgroundColor,
    ));

    Size size = MediaQuery.of(context).size;

    // Material Scaffold Widget
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                color: const Color(0xff000000)
            ),
            child: Stack(children: [
              Center(
                child: new Image.asset(
                  'assets/images/welcome_background.png',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,
                ),
              ),
              PositionedDirectional(
                top: 0,
                start: 0,
                child:
                Container(
                    width: ScreenUtil().setWidth(414),
                    height: ScreenUtil().setHeight(896)
                ),
              ),
              PositionedDirectional(
                top: 0,
                start: 0,
                child:
                Container(
                    width: ScreenUtil().setWidth(414),
                    height: ScreenUtil().setHeight(896),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(0.5164458786231885, 0.46336146763392855),
                            end: Alignment(0.5164458786231885, 1),
                            colors: [const Color(0xad000000), const Color(0x00ffffff)])
                    )
                ),
              ),
              PositionedDirectional(
                top: 0,
                start: 0,
                child:
                Opacity(
                  opacity : 0.5,
                  child:   Container(
                      width: ScreenUtil().setWidth(414),
                      height: ScreenUtil().setHeight(896),
                      decoration: BoxDecoration(
                          color: const Color(0xff000000)
                      )
                  ),
                ),
              ),
              PositionedDirectional(
                top: ScreenUtil().setHeight(825),
                start: ScreenUtil().setWidth(83),
                child:
                SizedBox(
                    width: ScreenUtil().setWidth(270),
                    height: ScreenUtil().setHeight(50),
                    child:   InkWell(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.APP_ROUTE_REGISTER),
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: ScreenUtil().setSp(15.0)
                                    ),
                                    text: "Don’t have an account? "),
                                TextSpan(
                                    style: TextStyle(
                                        color:  AppColors.PRIMARY_COLOR,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: ScreenUtil().setSp(15.0)
                                    ),
                                    text: "Sign up now")
                              ]
                          )
                      ),
                    )
                ),
              ),
              // Get Started
              PositionedDirectional(
                top: ScreenUtil().setHeight(740),
                start: ScreenUtil().setWidth(40),
                child:
                SizedBox(
                    child:  Hero(
                      tag: "button",
                      child: RaisedButton(
                        child: Text(
                            "Log In",
                            style: buttonTextStyle,
                            textAlign: TextAlign.center
                        ),
                        animationDuration: Duration(seconds: 2),
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.APP_ROUTE_LOGIN)
                      ),
                    )
                ),
              ),
              // Fashion4Cast
              PositionedDirectional(
                top: ScreenUtil().setHeight(335),
                start: ScreenUtil().setWidth(0),
                child:
                SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: Center(
                      child: Text(
                          "Fashion4Cast",
                          style: logoStyle,
                          textAlign: TextAlign.center
                      )
                  ),
                ),
              )
            ])
        ),
      );
  }
}