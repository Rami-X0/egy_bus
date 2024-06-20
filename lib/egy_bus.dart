
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/di/dependency_injection.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart' as route;

class EgyBus extends StatelessWidget {
  const EgyBus({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider.value(
        value: getIt<PassengerHomeCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          initialRoute: determineInitialRoute(),
          onGenerateRoute: route.generateRoute,
        ),
      ),
    );
  }

  String determineInitialRoute() {
    if (onBoarding == null) {
      return Routes.onBoarding;
    } else if (passengerUserId != null) {
      return Routes.passengerHome;
    } else if (driverUserId != null) {
      return Routes.driverHome;
    } else {
      return Routes.chooseUser;
    }
  }
}
