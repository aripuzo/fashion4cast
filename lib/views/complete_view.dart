import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      child:  RaisedButton(
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
}

class ScreenArguments {
  final String message;
  final String route;

  ScreenArguments(this.message, this.route);
}