import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/scale_fade_align.dart';
import 'package:egy_bus/features/passenger_login/ui/widgets/bloc_listener_passenger_login.dart';
import 'package:egy_bus/features/passenger_login/ui/widgets/passenger_login_button.dart';
import 'package:egy_bus/features/passenger_login/ui/widgets/passenger_login_dont_have_account.dart';
import 'package:egy_bus/features/passenger_login/ui/widgets/passenger_login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PassengerLoginScreen extends StatelessWidget {
  const PassengerLoginScreen({super.key});

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
                      'Sign in to Your Account',
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
                        const PassengerLoginForm(),
                        Gap(25.h),
                        const PassengerLoginButton(),
                        Gap(25.h),
                        const PassengerLoginDontHaveAccount(),
                        const BlocListenerPassengerLogin(),
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
