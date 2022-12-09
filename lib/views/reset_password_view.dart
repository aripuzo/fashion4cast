import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/reset_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_animation.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with TickerProviderStateMixin {

  ResetPasswordViewModel _viewModel;

  AnimationController _loginButtonController;

  // Toggle variable for Log-In process
  bool _isLoading;

  String email;

  @override
  void initState() {

    _viewModel = ResetPasswordViewModel(App());

    subscribeToViewModel();

    // Log-in process in not initiated yet
    _isLoading = false;

    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);

    //email = widget.args.message

    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context).settings.arguments;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColors.BACKGROUND_COLOR,
    ));

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
                      "Reset password",
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
                          "Enter the OTP sent to this email $email",
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
                        .getResetPasswordFormObserver()
                        .userTokenErrorText,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: ScreenUtil().setWidth(355),
                        child: TextFormField(
                          style: formTextStyle,
                          keyboardType: TextInputType.text,
                          controller: _viewModel.userTokenController,
                          decoration: InputDecoration(
                            labelText: "Token",
                            hintText: "Enter token",
                            errorText: snapshot.data,
                          ),
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  StreamBuilder(
                      stream: _viewModel
                          .getResetPasswordFormObserver()
                          .userPasswordErrorText,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: ScreenUtil().setWidth(355),
                          child: TextFormField(
                            style: formTextStyle,
                            keyboardType: TextInputType.text,
                            controller: _viewModel.userPasswordController,
                            decoration: InputDecoration(
                              labelText: AppStrings.LOGIN_USER_PASSWORD_LABEL,
                              hintText: "Enter new password",
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
                          .getResetPasswordFormObserver()
                          .isLoginEnabled,
                      builder: (context, snapshot) {
                        return SizedBox(
                            width: ScreenUtil().setWidth(355),
                            child:  ElevatedButton(
                              child: Text(
                                  "Complete Reset",
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
                                _viewModel.resetPassword(
                                  email: email,
                                  password: _viewModel.userPasswordController.text,
                                  token: _viewModel.userTokenController.text
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

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  void subscribeToViewModel() {

    _viewModel.getResetPasswordResponse()
        .listen(
            (message){

          setState(() {
            _isLoading = false;
            _stopAnimation();
            if(message == null){
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(msg: message);
            }
          });

        });

  }
}