import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font30MainColorBold = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.mainColor,
  );
  static TextStyle font28WhiteSemiBold = TextStyle(
    fontSize: 28.sp,
    color: Colors.white,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font60MainColorBold = TextStyle(
    fontSize: 60.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.mainColor,
  );
  static TextStyle font15DarkBlueMedium =  TextStyle(
    fontSize: 15.sp,
    color: ColorsManager.darkBlue,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font11BlackMedium =  TextStyle(
    color: Colors.black,
    fontSize: 11.sp,
    fontWeight: FontWeightHelper.medium,
  );

}
