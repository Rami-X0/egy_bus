import 'package:egy_bus/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final Color? backGroundColor;
  final double? verticalSize;
  final double? horizontalSize;
  final double? border;
  final Color? shadowColor;
  final double? elevationShadow;
 final Widget? child;
  const AppTextButton({
    super.key,
    required this.onPressed,
     this.text,
     this.textStyle,
    this.backGroundColor,
    this.verticalSize,
    this.horizontalSize,
    this.border,
    this.shadowColor,
    this.elevationShadow, this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        animationDuration: const Duration(milliseconds: 750),
        elevation: WidgetStateProperty.all(elevationShadow ?? 5),
        shadowColor:
            WidgetStateProperty.all(shadowColor ?? ColorsManager.darkBlue),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              border ?? 16,
            ),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          backGroundColor ?? ColorsManager.mainColor,
        ),
        minimumSize: WidgetStateProperty.all(
          Size(
            horizontalSize ?? 335.w,
            verticalSize ?? 77.h,
          ),
        ),
      ),
      onPressed: onPressed,
      child:child?? Text(
        text!,
        style: textStyle,
      ),
    );
  }
}
