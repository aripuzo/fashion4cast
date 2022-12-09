import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/forgot_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_animation.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with TickerProviderStateMixin {

  ForgotPasswordViewModel _viewModel;

  AnimationController _loginButtonController;

  // Toggle variable for Log-In process
  bool _isLoading;

  String email;

  @override
  void initState() {

    _viewModel = ForgotPasswordViewModel(App());

    subscribeToViewModel();


    // Log-in process in not initiated yet
    _isLoading = false;

    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);

    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      //await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {

//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//      statusBarColor: AppColors.BACKGROUND_COLOR,
//    ));

    // Material Scaffold Widget
    return Container(
      decoration: BoxDecoration(
          color: AppColors.BACKGROUND_COLOR
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0
        ),
        body: Stack(children: [
          PositionedDirectional(
            top: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtil().setWidth(355),
                    child: Text(
                      "Forgotten password",
                      style: titleTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(71),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(331),
                      child:   Text(
                          "Kindly enter your email below, so we can email you an OTP to reset your password",
                          style: TextStyle(
                              color:  Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "HelveticaNeue",
                              fontStyle:  FontStyle.normal,
                              fontSize: ScreenUtil().setSp(17.0)
                          )
                      )
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(32),
                  ),
                  StreamBuilder(
                    stream: _viewModel
                      .getForgotPasswordFormObserver()
                      .userEmailErrorText,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: ScreenUtil().setWidth(355),
                        child: TextFormField(
                          style: formTextStyle,
                          keyboardType: TextInputType.emailAddress,
                          controller: _viewModel.userEmailController,
                          decoration: InputDecoration(
                            labelText: AppStrings.LOGIN_USER_NAME_LABEL,
                            hintText: AppStrings.LOGIN_USER_NAME_HINT,
                            errorText: snapshot.data,
                          ),
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(23),
                  ),
                  !_isLoading
                      ?
                  StreamBuilder(
                    stream: _viewModel
                      .getForgotPasswordFormObserver()
                      .isLoginEnabled,
                    builder: (context, snapshot) {
                      return SizedBox(
                          width: ScreenUtil().setWidth(355),
                          child:  ElevatedButton(
                            child: Text(
                                "Reset Password",
                                style: TextStyle(
                                    color:  Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: ScreenUtil().setSp(18.0)
                                ),
                                textAlign: TextAlign.center
                            ),
                              onPressed: snapshot.data ?? false
                                  ?
                                  () {
                                setState(() {
                                  _isLoading = true;
                                });
                                _playAnimation();
                                email = _viewModel.userEmailController.text;
                                _viewModel.forgotPassword(
                                    email: email
                                );
                              }
                                  :
                              null,
                          )
                      );
                    }
                  )
                      :
                  StaggerAnimation(
                      buttonController:
                      _loginButtonController.view),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(355),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Center(
                          child: Text("Cancel password reset",
                              style: TextStyle(
                                fontFamily: 'HelveticaNeue',
                                color: Color(0xff94ff00),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            bottom: ScreenUtil().setHeight(30),
            start: ScreenUtil().setWidth(151),
            child:
            SizedBox(
                child:!_keyboardIsVisible() ?
                Text(
                    "Fashion4Cast",
                    style: smallLogoStyle,
                    textAlign: TextAlign.center
                )
                    :
                SizedBox()
            ),
          )
        ]),
      ),
    );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  void subscribeToViewModel() {

    _viewModel.getForgotPasswordResponse()
        .listen(
            (message){

          setState(() {
            _isLoading = false;
            _stopAnimation();
            if(message == null){
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyRecord("WonderWorld")));
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.APP_ROUTE_RESET_PASSWORD,
                arguments: email,
              );
            } else {
              Fluttertoast.showToast(msg: message);
            }
          });

        });

  }
}