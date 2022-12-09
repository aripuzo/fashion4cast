import 'package:email_validator/email_validator.dart';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_animation.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {

  LoginViewModel _viewModel;

  bool _passwordVisible;

  // Toggle variable for Log-In process
  bool _isLoading;

  AnimationController _loginButtonController;

  @override
  void initState() {

    // Initialize view-model variable
    _viewModel = LoginViewModel(App());

    // Method to subscribe event of view-model
    subscribeToViewModel();

    // Initially password is obscured
    _passwordVisible = false;

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
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtil().setWidth(355),
                    child: Text(
                      AppStrings.LOGIN_TITLE,
                      style: titleTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(73),
                  ),
                  StreamBuilder(
                    stream:  _viewModel
                        .getLoginFormObserver()
                        .userNameErrorText,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: ScreenUtil().setWidth(355),
                        child: TextFormField(
                          style: formTextStyle,
                          keyboardType: TextInputType.emailAddress,
                          controller: _viewModel.userNameController,
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
                    height: ScreenUtil().setHeight(20),
                  ),
                  StreamBuilder(
                      stream:  _viewModel
                          .getLoginFormObserver()
                          .userPasswordErrorText,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: ScreenUtil().setWidth(355),
                        child: TextFormField(
                          style: formTextStyle,
                          keyboardType: TextInputType.text,
                          controller: _viewModel.userPasswordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: AppStrings.LOGIN_USER_PASSWORD_LABEL,
                            hintText: AppStrings.LOGIN_USER_PASSWORD_HINT,
                            errorText: snapshot.data,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible
                                      ? _passwordVisible = false
                                      : _passwordVisible = true;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(23),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(355),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.APP_ROUTE_FORGOT_PASSWORD);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                            child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                    color:  AppColors.PRIMARY_COLOR.withOpacity(0.699999988079071),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: ScreenUtil().setSp(14.0)
                                ),
                                textAlign: TextAlign.end
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(23),
                  ),
                  !_isLoading
                      ?
                  StreamBuilder(
                      stream: _viewModel
                          .getLoginFormObserver()
                          .isLoginEnabled,
                    builder: (context, snapshot) {
                      return SizedBox(
                          width: ScreenUtil().setWidth(355),
                          child:  Hero(
                            tag: "button",
                            child: ElevatedButton(
                              child: Text(
                                  AppStrings.LOGIN_LOGIN_BUTTON_LABEL,
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
                              onPressed: () {
                                if(EmailValidator.validate(_viewModel.userNameController
                                    .text) && _viewModel
                                    .userPasswordController.text.length > 6) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _playAnimation();
                                  _viewModel.checkLogin(
                                      userName: _viewModel.userNameController
                                          .text,
                                      userPassword: _viewModel
                                          .userPasswordController.text);
                                }
                                else
                                  Fluttertoast.showToast(msg: "Enter valid information");
                              },
                            ),
                          )
                      );
                    }
                  )
                      :
                  StaggerAnimation(
                      buttonController:
                      _loginButtonController.view),
                  SizedBox(
                    height: ScreenUtil().setHeight(36),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(355),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                             Navigator.pushNamed(context, AppRoutes.APP_ROUTE_REGISTER);
                          },
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
                                        text: "Don’t have an account yet? "),
                                    TextSpan(
                                        style: TextStyle(
                                            color: AppColors.PRIMARY_COLOR,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(15.0)
                                        ),
                                        text: "Sign up now")
                                  ]
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

    _viewModel.getLoginResponse()
        .listen(
            (message){

          setState(() {
            _isLoading = false;
            _stopAnimation();
            if(message == null){
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.APP_ROUTE_MAIN, (Route<dynamic> route) => false);
            } else {
              Fluttertoast.showToast(msg: message);
            }
          });

        });

  }
}