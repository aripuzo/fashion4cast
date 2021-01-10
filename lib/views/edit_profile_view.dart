import 'dart:io';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/app_strings.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/edit_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'login_animation.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with TickerProviderStateMixin {

  EditProfileViewModel _viewModel;

  bool _isLoading;

  AnimationController _loginButtonController;

  Future<File> imageFile;

  @override
  void initState() {

    _viewModel = EditProfileViewModel(App());
    subscribeToViewModel();

    _isLoading = false;

    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);

    super.initState();
  }

  Future<void> _askedToUpload() async {
    switch (await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Choose image upload option',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "HelveticaNeue",
                  fontStyle:  FontStyle.normal,
                  fontSize: ScreenUtil().setSp(18.0)
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () { getImage(ImageSource.camera); Navigator.pop(context);},
                child: Text(
                    'Camera',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "HelveticaNeue",
                        fontStyle:  FontStyle.normal,
                        fontSize: ScreenUtil().setSp(15.0)
                    )
                ),
              ),
              SimpleDialogOption(
                onPressed: () { getImage(ImageSource.gallery); Navigator.pop(context);},
                child: Text(
                    'Gallery',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "HelveticaNeue",
                        fontStyle:  FontStyle.normal,
                        fontSize: ScreenUtil().setSp(15.0)
                    )
                ),
              ),
            ],
          );
        }
    )) {
      case ImageSource.camera:
        break;
      case ImageSource.gallery:
        break;
    }
  }

  getImage(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context)
          .backgroundColor,
    ));

    return Container(
      decoration: BoxDecoration(
          color: Colors.black
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
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
                height: ScreenUtil.defaultSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    Text(
                        "Edit profile",
                        style: titleTextStyle
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(74),
                    ),
                    Center(
                      child: InkWell(
                        onTap:() => _askedToUpload(),
                        child: Container(
                          width: ScreenUtil().setHeight(180),
                          height: ScreenUtil().setHeight(180),
                          padding: EdgeInsets.all(ScreenUtil().setHeight(2.0)),
                          decoration: new BoxDecoration(
                            color: Colors.white, // border color
                            shape: BoxShape.circle,
                          ),
                          child: FutureBuilder<File>(
                            future: imageFile,
                            builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                              if (snapshot.error != null) {
                                return const Text(
                                  'Error Picking Image',
                                  textAlign: TextAlign.center,
                                );
                              }
//                            else if (snapshot.connectionState == ConnectionState.done &&
//                                snapshot.data != null) {
                              else {
                                return CircleAvatar(
                                    backgroundImage: snapshot.data != null ?
                                      FileImage(snapshot.data): _viewModel.user.avatar != null ?
                                      NetworkImage(_viewModel.user.avatar):
                                      ExactAssetImage('assets/images/avatar.png'),
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.PRIMARY_COLOR
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(71),
                    ),
                    StreamBuilder<String>(
                      stream: _viewModel.getRegisterFormObserver().firstNameErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _viewModel.firstNameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: AppStrings.REGISTER_FIRST_NAME_LABEL,
                            hintText: AppStrings.REGISTER_FIRST_NAME_HINT,
                            errorText: snapshot.data,
                          ),
                        );
                      }
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    StreamBuilder<Object>(
                      stream: _viewModel.getRegisterFormObserver().lastNameErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
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
                      height: ScreenUtil().setHeight(30),
                    ),
                    StreamBuilder<String>(
                      stream: _viewModel.getRegisterFormObserver().userEmailErrorText,
                      builder: (context, snapshot) {
                        return TextFormField(
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
                      height: ScreenUtil().setHeight(30),
                    ),
                    !_isLoading
                      ?
                    Container(
                      child: StreamBuilder(
                        //stream: _viewModel.getRegisterFormObserver().isRegisterEnabled,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: ScreenUtil().setWidth(355),
                            child: RaisedButton(
                              child: Text(
                                  AppStrings.CHANGE_PASSWORD_BUTTON_LABEL,
                                  style: TextStyle(
                                      color:  const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: ScreenUtil().setSp(18.0)
                                  ),
                                  textAlign: TextAlign.center
                              ),
                              animationDuration: Duration(seconds: 2),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                _playAnimation();
                                _viewModel.updateUser(
                                  firstName: _viewModel.firstNameController.text,
                                  lastName: _viewModel.lastNameController.text,
                                  userEmail: _viewModel.userEmailController.text
                                );
                                if(imageFile != null)
                                  imageFile.then((value) => _viewModel.updateImage(file: value));
                              },
                            ),
                          );
                        }
                      ),
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
//              Positioned(
//                bottom: ScreenUtil().setHeight(30),
//                child:
//                SizedBox(
//                    //height: 21,
//                    width: ScreenUtil.screenWidth,
//                    child: !_keyboardIsVisible() ?
//                    Text(
//                        "Fashion4Cast",
//                        style: smallLogoStyle,
//                        textAlign: TextAlign.center
//                    )
//                        :
//                    SizedBox()
//                ),
//              )
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
    _viewModel.destroy();
    super.dispose();
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  void subscribeToViewModel() {

    _viewModel.getRegisterResponse()
        .listen(
            (message){
          setState(() {
            _stopAnimation();
            _isLoading = false;
            _stopAnimation();
            Fluttertoast.showToast(msg: message);
          });

        });

  }
}