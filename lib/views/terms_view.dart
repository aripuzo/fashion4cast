import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_styles.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//class Terms extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: AppStyles.defaultTheme(),
//      home: _TermsView(),
//      onGenerateRoute: App().getAppRoutes().getRoutes,
//    );
//  }
//}

class Terms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TermsState();
}

class _TermsState extends State<Terms> {

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

    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0
      ),
      body: SafeArea(
        child:
        Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(
                    width: ScreenUtil().setWidth(196),
                    height: ScreenUtil().setHeight(38),
                    child:   Text(
                        "Terms of use",
                        style: titleTextStyle
                    )
                ),
                SizedBox(height: ScreenUtil().setHeight(61),),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Text(
                          "Officia ullamco fugiat officia proident aliqua non nulla Lorem ut ut et commodo est. "
                              "Minim labore velit adipisicing et mollit irure esse eiusmod ipsum veniam occaecat "
                              "ex magna velit. Enim magna labore ipsum laborum occaecat voluptate excepteur eu consectetur. "
                              "Dolore proident pariatur culpa in. Enim aliqua consequat do quis sit. Ut nostrud "
                              "ea consequat mollit adipisicing commodo velit voluptate nisi occaecat adipisicing excepteur. "
                              "Sint irure cupidatat non occaecat dolore. Aliquip ut deserunt consectetur labore cillum "
                              "nostrud eiusmod laboris tempor nulla. Non Lorem officia nulla do ipsum officia tempor. "
                              "Deserunt ex esse minim tempor aliquip incididunt proident velit id. Adipisicing magna "
                              "consequat fugiat nulla reprehenderit sint sunt eiusmod esse esse ut nulla nisi. Irure "
                              "veniam ex ex aute consectetur officia aliquip exercitation in. Proident reprehenderit ad "
                              "labore adipisicing dolor aute duis est et commodo in mollit. Sunt amet labore irure irure. "
                              "Ut deserunt ex anim est consequat sunt quis ea aute incididunt fugiat ex eiusmod. "
                              "In fugiat cillum eiusmod ut veniam eu eiusmod nostrud aliquip ad dolore veniam esse in. "
                              "Enim amet cillum excepteur est quis id laboris adipisicing consectetur officia sit consectetur ut eu. "
                              "Laborum voluptate mollit fugiat elit qui excepteur in aute nisi sunt eu esse adipisicing cupidatat. "
                              "Laboris esse non consectetur mollit eu do. Consectetur amet qui dolore ullamco nostrud. "
                              "Laboris non ex minim qui consequat fugiat sunt elit enim non nisi eu mollit cupidatat. "
                              "Incididunt tempor tempor deserunt elit nulla culpa. Consectetur pariatur nostrud labore est "
                              "labore elit cupidatat. Anim dolor quis consectetur nisi dolor elit veniam amet.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "HelveticaNeue",
                              fontStyle:  FontStyle.normal,
                              fontSize: ScreenUtil().setSp(15.0)
                          )
                      )
                    ],
                  ),
                ),
                  SizedBox(
                    height: ScreenUtil().setHeight(55),
                  ),
              ]),
            ),
            PositionedDirectional(
              bottom: ScreenUtil().setHeight(30),
              start: ScreenUtil().setWidth(151),
              child:
              SizedBox(
                  width: 106,
                  height: 21,
                  child:   Text(
                      "Fashion4Cast",
                      style: smallLogoStyle,
                      textAlign: TextAlign.center
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}