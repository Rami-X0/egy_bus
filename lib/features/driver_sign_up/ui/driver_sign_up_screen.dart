import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/scale_fade_align.dart';
import 'package:egy_bus/features/driver_sign_up/ui/widgets/bloc_listener_driver_sign_up.dart';
import 'package:egy_bus/features/driver_sign_up/ui/widgets/driver_sign_up_button.dart';
import 'package:egy_bus/features/driver_sign_up/ui/widgets/driver_sign_up_form.dart';
import 'package:egy_bus/features/driver_sign_up/ui/widgets/driver_sign_up_have_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DriverSignUpScreen extends StatelessWidget {
  const DriverSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppScaleFadeAlign(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    child: Text(
                      'Welcome',
                      style: TextStyles.font30MainColorBold
                          .copyWith(color: ColorsManager.darkBlue),
                    ),
                  ),
                  AppScaleFadeAlign(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    child: Text(
                      'Sign Up to Your Account',
                      style: TextStyles.font30MainColorBold.copyWith(
                          color: ColorsManager.darkBlue,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  AppScaleFadeAlign(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gap(18.h),
                        const DriverSignUpForm(),
                        Gap(25.h),
                        const DriverSignUpButton(),
                        Gap(25.h),
                        const DriverSignUpHaveAccount(),
                        const BlocListenerDriverSignUp(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
