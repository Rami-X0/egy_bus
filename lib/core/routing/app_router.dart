import 'package:egy_bus/core/di/dependency_injection.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/features/choose_user/choose_user.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_cubit.dart';
import 'package:egy_bus/features/driver_home/ui/driver_home.dart';
import 'package:egy_bus/features/driver_home/ui/station_link_screen.dart';
import 'package:egy_bus/features/driver_login/logic/cubit/driver_login_cubit.dart';
import 'package:egy_bus/features/driver_login/ui/driver_login_screen.dart';
import 'package:egy_bus/features/driver_sign_up/logic/cubit/driver_sign_up_cubit.dart';
import 'package:egy_bus/features/driver_sign_up/ui/driver_sign_up_screen.dart';
import 'package:egy_bus/features/on_boarding/ui/on_boarding_screen.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:egy_bus/features/passenger_home/ui/passenger_home.dart';
import 'package:egy_bus/features/passenger_home/ui/passenger_profile.dart';
import 'package:egy_bus/features/passenger_home/ui/station_link_screen.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_cubit.dart';
import 'package:egy_bus/features/passenger_login/ui/passenger_login_screen.dart';
import 'package:egy_bus/features/passenger_sign_up/logic/cubit/passenger_sign_up_cubit.dart';
import 'package:egy_bus/features/passenger_sign_up/ui/passenger_sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.onBoarding:
      return MaterialPageRoute(
        builder: (_) => const OnBoardingScreen(),
      );
    case Routes.chooseUser:
      return MaterialPageRoute(
        builder: (_) => const ChooseAccountUser(),
      );
    case Routes.driverSignUp:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: getIt<DriverSignUpCubit>(),
            child: const DriverSignUpScreen()),
      );

    case Routes.driverLogin:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: getIt<DriverLoginCubit>(), child: const DriverLoginScreen()),
      );
    case Routes.driverHome:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: getIt<DriverHomeCubit>(),
          child: const DriverHomeScreen(),
        ),
      );
    case Routes.driverStationLink:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: getIt<DriverHomeCubit>(),
            child: const DriverStationLinkScreen()),
      );
    case Routes.passengerLogin:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<PassengerLoginCubit>()),
          BlocProvider.value(value: getIt<PassengerHomeCubit>()),
        ], child: const PassengerLoginScreen()),
      );
    case Routes.passengerSignUp:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: getIt<PassengerSignUpCubit>(),
            child: const PassengerSignUpScreen()),
      );
    case Routes.passengerHome:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: getIt<PassengerHomeCubit>(),
            child: const PassengerHomeScreen()),
      );
    // case Routes.passengerStationLink:
    //   return MaterialPageRoute(
    //     builder: (_) => BlocProvider.value(
    //         value: getIt<PassengerHomeCubit>(),
    //         child: const PassengerStationLinkScreen()),
    //   );
    case Routes.passengerProfile:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: getIt<PassengerHomeCubit>(),
            child: const PassengerProfile()),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
