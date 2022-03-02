import 'dart:io';

import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  SettingsViewModel _viewModel;


  @override
  void initState() {
    _viewModel = SettingsViewModel(App());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context)
          .backgroundColor,
    ));

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
          child:
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(27.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                        width: ScreenUtil.defaultSize.height,
                        //height: ScreenUtil().setHeight(38),
                        child:   Text(
                            "Settings",
                            style: titleTextStyle
                        )
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(3.0),
                            right: ScreenUtil().setWidth(3.0),
                            bottom: ScreenUtil().setHeight(70)
                        ),
                        children: [
                        // Settings
                          SizedBox(
                            height: ScreenUtil().setHeight(60),
                          ),
                          HeaderItem(
                            title: "Account details",
                            image: "assets/images/person.png",
                          ),
                          _bodyItem(
                            item: "Edit Profile",
                            index: 0,
                          ),
                          _bodyItem(
                              item: "Change Password",
                            index: 1,
                          ),
                          // HeaderItem(
                          //   title: "Notifications",
                          //   image: "assets/images/bell_ring_notification_alarm.png",
                          // ),
                          // _bodyItem(
                          //   item: "App notifications",
                          //   hasSwitch: true,
                          //   index: 2,
                          // ),
                          HeaderItem(
                            title: "Others",
                          ),
                          _bodyItem(
                            item: "Use Current Location",
                            hasSwitch: true,
                            index: 2,
                          ),
                          _bodyItem(
                            item: "Locations",
                            index: 3,
                          ),
                          _bodyItem(
                            item: "Use fahrenheit",
                            hasSwitch: true,
                            index: 4,
                          ),
                          _bodyItem(
                            item: "Privacy Policy",
                            index: 5,
                          ),
                      ]),
                    ),
                  ],
                ),
                Platform.isAndroid ?
                PositionedDirectional(
                  bottom: ScreenUtil().setHeight(34),
                  child:
                  InkWell(
                    onTap: ()=> _showLogout(),
                    child: Container(
                        width: ScreenUtil().setWidth(355),
                        height: ScreenUtil().setHeight(75),
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12)),
                        child: Column(
                          children: <Widget>[
                            Text("Sign out of Fashion4Cast",
                                style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  color: AppColors.PRIMARY_COLOR,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )
                            ),
                            Text(_viewModel.user.email,
                                style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  color: AppColors.PRIMARY_COLOR.withOpacity(0.4000000059604645),
                                  fontSize: ScreenUtil().setSp(13),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(4)
                            ),
                            border: Border.all(
                                color: AppColors.PRIMARY_COLOR,
                                width: 1
                            )
                        )
                    ),
                  ),
                ) :
                SizedBox()
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyItem({@required int index, String item, bool hasSwitch = false}) {
    return new InkWell(
        onTap: () {
          switch(index) {
            case 0:{
              Navigator.pushNamed(context, AppRoutes.APP_ROUTE_EDIT_PROFILE);
              break;
            }
            case 1:{
              Navigator.pushNamed(context, AppRoutes.APP_ROUTE_CHANGE_PASSWORD);
              break;
            }
            case 3:{
              Navigator.pushNamed(context, AppRoutes.APP_ROUTE_SELECT_CITIES);
              break;
            }
            case 5:{
              //Navigator.pushNamed(context, AppRoutes.APP_ROUTE_TERMS);
              _openPrivacyPolicy();
              break;
            }
            default:{}
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            title:Text(
                item,
                style: TextStyle(
                  color:  Colors.white.withOpacity(0.699999988079071),
                  fontFamily: "HelveticaNeue",
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                )
            ),
            trailing: hasSwitch ?
            Switch(
              value: index == 2 ? _viewModel.useCurrentLocation : _viewModel.useF,
              activeColor: AppColors.PRIMARY_COLOR,
              inactiveThumbColor: Colors.grey,
              onChanged: (changed) {
                setState(() {
                  index == 2
                      ? _viewModel.setUseCurrentLocation(changed)
                      : _viewModel.setUseF(changed);
                });
              },
            )
                :
            Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.white.withOpacity(0.699999988079071),
            )
            ,
          ),
        )
    );
  }
  void _openPrivacyPolicy() async {
    String url = "https://api.fashion4castapp.com/privacy-policy";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  Future<void> _showLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                _logOut();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> _logOut() async {
    _viewModel.logout();
    Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_WELCOME);
  }

}

class HeaderItem extends StatelessWidget {
  HeaderItem({this.title, this.image});
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
      child: Row(
        children: <Widget>[
          image != null ?
          Image.asset(
            image,
            height: ScreenUtil().setHeight(16),
            width: ScreenUtil().setWidth(16),
            color: Colors.white
          )
              :
              SizedBox()
          ,
          SizedBox(width: ScreenUtil().setWidth(9),),
          Text(
              title,
              style: TextStyle(
                  color:  Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "HelveticaNeue",
                  fontStyle:  FontStyle.normal,
                  fontSize: ScreenUtil().setSp(18.0)
              )
          ),
        ],
      ),
    );
  }
}