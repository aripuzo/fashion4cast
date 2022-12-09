import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/change_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_animation.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with TickerProviderStateMixin {

  ChangePasswordViewModel _viewModel;

  bool _isLoading;

  AnimationController _loginButtonController;

  @override
  void initState() {

    _viewModel = ChangePasswordViewModel(App());
    subscribeToViewModel();

    _isLoading = false;

    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context)
          .backgroundColor,
    ));

    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: AppColors.BACKGROUND_COLOR
      ),
      child: Scaffold(
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
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                height: ScreenUtil.defaultSize.height,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text(
                        "Change password",
                        style: titleTextStyle
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(74),
                    ),
                    StreamBuilder(
                      stream: _viewModel.getChangePasswordFormObserver().oldPasswordErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _viewModel.oldPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppStrings.CHANGE_PASSWORD_CURRENT_PASSWORD_LABEL,
                            hintText: AppStrings.CHANGE_PASSWORD_CURRENT_PASSWORD_HINT,
                            errorText: snapshot.data,
                          ),
                        );
                      }
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    StreamBuilder(
                      stream: _viewModel.getChangePasswordFormObserver().newPasswordErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _viewModel.newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppStrings.CHANGE_PASSWORD_NEW_PASSWORD_LABEL,
                            hintText: AppStrings.CHANGE_PASSWORD_NEW_PASSWORD_HINT,
                            errorText: snapshot.data,
                          ),
                        );
                      }
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    StreamBuilder(
                      stream: _viewModel.getChangePasswordFormObserver().confirmPasswordErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _viewModel.confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppStrings.CHANGE_PASSWORD_CONFIRM_PASSWORD_LABEL,
                            hintText: AppStrings.CHANGE_PASSWORD_CONFIRM_PASSWORD_HINT,
                            errorText: snapshot.data,
                          ),
                        );
                      }
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    !_isLoading
                      ?
                    StreamBuilder<Object>(
                      stream: _viewModel.getChangePasswordFormObserver().isLoginEnabled,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: ScreenUtil().setWidth(355),
                          child: ElevatedButton(
                            child: Text(
                                AppStrings.CHANGE_PASSWORD_BUTTON_LABEL,
                                style: TextStyle(
                                    color:  AppColors.BACKGROUND_COLOR,
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
                              _viewModel.changePassword(
                                  oldPassword: _viewModel.oldPasswordController.text,
                                  password: _viewModel.newPasswordController.text,
                                  confirmPassword: _viewModel.confirmPasswordController.text
                              );
                            }
                                :
                            null,
                          ),
                        );
                      }
                    )
                        :
                    StaggerAnimation(
                        buttonController:
                        _loginButtonController.view),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                  ]),
                ),
              ),
              Positioned(
                bottom: ScreenUtil().setHeight(30),
                child:
                SizedBox(
                  //height: 21,
                    width: size.width,
                    child: !_keyboardIsVisible() ?
                    Text(
                        "Fashion4Cast",
                        style: smallLogoStyle,
                        textAlign: TextAlign.center
                    )
                        :
                    SizedBox()
                ),
              )
            ],
          ),
        ),
      ),
    );
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
            if(message != null){
              Fluttertoast.showToast(msg: message);
            }
          });

        });

  }
}