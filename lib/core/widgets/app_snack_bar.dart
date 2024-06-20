import 'package:egy_bus/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> appSnackBar({
  required String text,
  required Color backGroundColor,
  required context,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Text(
            text,
            style: TextStyles.font28WhiteSemiBold.copyWith(
              fontSize: 15.sp,
              color: Colors.white
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              maxRadius: 10.w,
              child: FaIcon(
                FontAwesomeIcons.x,
                size: 8.w,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 1150),
      hitTestBehavior: HitTestBehavior.opaque,
      backgroundColor: backGroundColor,
      elevation: 3,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 95.h),
    ),
  );
}
