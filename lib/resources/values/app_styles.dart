import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// App Styles Class -> Resource class for storing app level styles constants
class AppStyles {

  // Light Theme
  static ThemeData defaultTheme(){
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      //primarySwatch: Colors.orange,
      backgroundColor: AppColors.BACKGROUND_COLOR,
      primaryColor: AppColors.PRIMARY_COLOR,
      primaryColorLight: AppColors.PRIMARY_COLOR,
      primaryColorDark: AppColors.PRIMARY_COLOR,
      accentColor: AppColors.ACCENT_COLOR,

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(20),
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
          fontWeight: FontWeight.normal,
          fontFamily: "HelveticaNeue",
          fontStyle:  FontStyle.normal,
          fontSize: ScreenUtil().setSp(18.0)
        ),
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: "HelveticaNeue",
          fontStyle:  FontStyle.normal,
          fontSize: ScreenUtil().setSp(18.0)
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontFamily: "HelveticaNeue",
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(12),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.TEXT_BORDER_COLOR,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.TEXT_BORDER_COLOR,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.RED_COLOR,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
      ),

      buttonTheme: ButtonThemeData(
        height: ScreenUtil().setHeight(60),
        minWidth: ScreenUtil().setWidth(334),
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        textTheme:ButtonTextTheme.normal,
        buttonColor: AppColors.PRIMARY_COLOR,
      ),
    );
  }

}