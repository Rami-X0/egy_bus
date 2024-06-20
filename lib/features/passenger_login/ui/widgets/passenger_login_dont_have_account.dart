import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PassengerLoginDontHaveAccount extends StatelessWidget {
  const PassengerLoginDontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Don\'tHave an account? ',
        style: TextStyles.font15DarkBlueMedium.copyWith(),
        children: [
          TextSpan(
              text: 'Sign Up',
              style: TextStyles.font15DarkBlueMedium.copyWith(
                fontSize: 17.sp,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context
                    .pushNamedAndRemoveUntil(Routes.passengerSignUp),


          ),
        ],
      ),
    );
  }
}
