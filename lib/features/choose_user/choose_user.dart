import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/core/widgets/scale_fade_align.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ChooseAccountUser extends StatelessWidget {
  const ChooseAccountUser({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            height: double.maxFinite,
            child: Stack(
              children: [
                AppScaleFadeAlign(
                  begin: Alignment.topCenter,
                  end: const Alignment(0.0, -0.6),
                  child: Container(
                    width: 160.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsManager.white,
                        width: 3.w,
                      ),
                      color: ColorsManager.mainColor,
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/egy_bus_logo.png'),
                      ),
                    ),
                  ),
                ),
                AppScaleFadeAlign(
                  begin: Alignment.bottomCenter,
                  end: const Alignment(0.0, 0.4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextButton(
                        onPressed: () {
                          context.pushNamed(Routes.driverLogin);
                        },
                        text: 'Driver',
                        textStyle: TextStyles.font28WhiteSemiBold,
                      ),
                      Gap(35.h),
                      AppTextButton(
                        onPressed: () {
                          context.pushNamed(Routes.passengerLogin);
                        },
                        text: 'Passenger',
                        textStyle: TextStyles.font28WhiteSemiBold,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
