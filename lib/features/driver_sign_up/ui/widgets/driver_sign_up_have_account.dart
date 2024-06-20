import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverSignUpHaveAccount extends StatelessWidget {
  const DriverSignUpHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Have an account? ',
        style: TextStyles.font15DarkBlueMedium.copyWith(),
        children: [
          TextSpan(
              text: 'Login',
              style: TextStyles.font15DarkBlueMedium.copyWith(
                fontSize: 17.sp,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context
                    .pushNamedAndRemoveUntil(Routes.driverLogin),


          ),
        ],
      ),
    );
  }
}
