import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'complete_view.dart';
import 'login_animation.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {

  RegisterViewModel _viewModel;

  bool _passwordVisible;

  bool _isLoading;

  AnimationController _registerButtonController;

  @override
  void initState() {

    _viewModel = RegisterViewModel(App());

    subscribeToViewModel();

    _passwordVisible = false;

    _isLoading = false;

    _registerButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);

    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      await _registerButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _registerButtonController.reverse();
    } on TickerCanceled {}
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
            height: ScreenUtil.defaultSize.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtil().setWidth(355),
                    child: Text(
                      AppStrings.REGISTER_TITLE,
                      style: titleTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(73),
                  ),
                  StreamBuilder(
                    stream: _viewModel
                          .getRegisterFormObserver()
                          .firstNameErrorText,
                    builder: (context, snapshot) {
                      return TextFormField(
                        style: formTextStyle,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        controller: _viewModel.firstNameController,
                        decoration: InputDecoration(
                          labelText: AppStrings.REGISTER_FIRST_NAME_LABEL,
                          hintText: AppStrings.REGISTER_FIRST_NAME_HINT,
                          errorText: snapshot.data,
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  StreamBuilder(
                      stream: _viewModel
                          .getRegisterFormObserver()
                          .lastNameErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: formTextStyle,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          controller: _viewModel.lastNameController,
                          decoration: InputDecoration(
                            labelText: AppStrings.REGISTER_LAST_NAME_LABEL,
                            hintText: AppStrings.REGISTER_LAST_NAME_HINT,
                            errorText: snapshot.data,
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  StreamBuilder(
                      stream: _viewModel
                          .getRegisterFormObserver()
                          .userEmailErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: formTextStyle,
                          keyboardType: TextInputType.emailAddress,
                          controller: _viewModel.userEmailController,
                          decoration: InputDecoration(
                            labelText: AppStrings.REGISTER_USER_EMAIL_LABEL,
                            hintText: AppStrings.REGISTER_USER_EMAIL_HINT,
                            errorText: snapshot.data,
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  StreamBuilder(
                    stream: _viewModel
                          .getRegisterFormObserver()
                          .userPhoneErrorText,
                    builder: (context, snapshot) {
                      return TextFormField(
                        style: formTextStyle,
                        keyboardType: TextInputType.phone,
                        controller: _viewModel.userPhoneController,
                        decoration: InputDecoration(
                          labelText: AppStrings.REGISTER_USER_PHONE_LABEL,
                          hintText: AppStrings.REGISTER_USER_PHONE_HINT,
                          errorText: snapshot.data,
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  StreamBuilder(
                    stream: null,
                    builder: (context, snapshot) {
                      return TextFormField(
                        style: formTextStyle,
                        keyboardType: TextInputType.text,
                        controller: _viewModel.userPasswordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: AppStrings.REGISTER_USER_PASSWORD_LABEL,
                          hintText: AppStrings.REGISTER_USER_PASSWORD_HINT,
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
                      );
                    }
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(23),
                  ),
                  !_isLoading
                      ?
                  StreamBuilder<Object>(
                    stream: _viewModel
                          .getRegisterFormObserver()
                          .isRegisterEnabled,
                    builder: (context, snapshot) {
                      return SizedBox(
                          width: ScreenUtil().setWidth(355),
                          child:  Hero(
                            tag: "button",
                            child: ElevatedButton(
                              child: Text(
                                  AppStrings.REGISTER_LOGIN_BUTTON_LABEL,
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
                              onPressed: snapshot.data ?? false
                                  ?
                                  () {
                                setState(() {
                                  _isLoading = true;
                                });
                                _playAnimation();
                                _viewModel.checkRegister(
                                    firstName: _viewModel.firstNameController.text,
                                    lastName: _viewModel.lastNameController.text,
                                    userEmail: _viewModel.userEmailController.text,
                                    userPhone: _viewModel.userPhoneController.text,
                                    countryCode: _viewModel.countryCode,
                                    userPassword: _viewModel.userPasswordController.text);
                              }
                                  :
                              null,
                            ),
                          )
                      );
                    }
                  )
                      :
                  StaggerAnimation(
                      buttonController:
                      _registerButtonController.view),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(355),
                      child:   Center(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context, false);
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
                                        text: "Already have an account? "),
                                    TextSpan(
                                        style: TextStyle(
                                            color: AppColors.PRIMARY_COLOR,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: ScreenUtil().setSp(15.0)
                                        ),
                                        text: "Sign in")
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
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _registerButtonController.dispose();
    super.dispose();
  }

  void subscribeToViewModel() {
    _viewModel.getRegisterResponse()
        .listen(
            (message){

          setState(() {

            _isLoading = false;
            _stopAnimation();
            if(message == null){
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.APP_ROUTE_COMPLETE,
                arguments: ScreenArguments(
                  'Account setup completed. You’re all set!',
                  AppRoutes.APP_ROUTE_MAIN,
                ),
              );
            } else {
              Fluttertoast.showToast(msg: message);
            }
          });

        });
  }
}