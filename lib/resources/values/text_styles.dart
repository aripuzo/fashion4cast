import 'dart:ui';

import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var logoStyle = TextStyle(
    fontFamily: 'AphasiaBT-Roman',
    color: AppColors.PRIMARY_COLOR,
    fontSize: ScreenUtil().setSp(40),
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
);

var smallLogoStyle = TextStyle(
    color:  Colors.white,
    fontWeight: FontWeight.w400,
    fontFamily: "AphasiaBT-Roman",
    fontStyle:  FontStyle.normal,
    fontSize: ScreenUtil().setSp(18.0)
);

var buttonTextStyle = TextStyle(
    color:  Colors.black,
    fontFamily: 'HelveticaNeue',
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal
);

var titleTextStyle = TextStyle(
    color:  Colors.white,
    fontWeight: FontWeight.w700,
    fontFamily: "HelveticaNeue",
    fontStyle:  FontStyle.normal,
    fontSize: ScreenUtil().setSp(32.0)
);

var formTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontFamily: "HelveticaNeue",
    fontStyle:  FontStyle.normal,
    fontSize: ScreenUtil().setSp(18.0)
);

var appName = "Fashion4Cast";