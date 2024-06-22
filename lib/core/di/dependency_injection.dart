import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_services.dart';
import 'package:egy_bus/core/networking/dio_factory.dart';
import 'package:egy_bus/features/driver_home/data/repo/driver_login_repo.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_cubit.dart';
import 'package:egy_bus/features/driver_login/data/repo/driver_login_repo.dart';
import 'package:egy_bus/features/driver_login/logic/cubit/driver_login_cubit.dart';
import 'package:egy_bus/features/driver_sign_up/data/repo/driver_sign_up_repo.dart';
import 'package:egy_bus/features/driver_sign_up/logic/cubit/driver_sign_up_cubit.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_login_repo.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:egy_bus/features/passenger_login/data/repo/passenger_login_repo.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_cubit.dart';
import 'package:egy_bus/features/passenger_sign_up/data/repo/passenger_sign_up_repo.dart';
import 'package:egy_bus/features/passenger_sign_up/logic/cubit/passenger_sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() async {
  Dio dio = await DioFactory.getDio();
  //ToDo: apiServices
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));

  //Todo: driverSignUp
  getIt
      .registerLazySingleton<DriverSignUpRepo>(() => DriverSignUpRepo(getIt()));

  getIt.registerLazySingleton<DriverSignUpCubit>(
      () => DriverSignUpCubit(getIt()));

  //Todo: driverLogin
  getIt.registerLazySingleton<DriverLoginRepo>(() => DriverLoginRepo(getIt()));

  getIt
      .registerLazySingleton<DriverLoginCubit>(() => DriverLoginCubit(getIt()));

  //Todo: driverHome
  getIt.registerLazySingleton<DriverHomeCubit>(() => DriverHomeCubit(getIt(),getIt()));
  getIt.registerLazySingleton<DriverHomeRepo>(() => DriverHomeRepo(getIt()));

  //Todo: passengerLogin
  getIt
      .registerLazySingleton<PassengerLoginRepo>(() => PassengerLoginRepo(getIt()));

  getIt
      .registerLazySingleton<PassengerLoginCubit>(() => PassengerLoginCubit(getIt()));

  //Todo: passengerSignUp
  getIt
      .registerLazySingleton<PassengerSignUpRepo>(() => PassengerSignUpRepo(getIt()));

  getIt
      .registerLazySingleton<PassengerSignUpCubit>(() => PassengerSignUpCubit(getIt()));

  //Todo: passengerHome
  getIt
      .registerLazySingleton<PassengerHomeCubit>(() => PassengerHomeCubit(getIt()));
  getIt
      .registerLazySingleton<PassengerHomeRepo>(() => PassengerHomeRepo(getIt()));
}
