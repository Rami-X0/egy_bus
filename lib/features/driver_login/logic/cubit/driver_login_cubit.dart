import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/features/driver_login/data/models/driver_login_request.dart';
import 'package:egy_bus/features/driver_login/data/models/driver_login_response.dart';
import 'package:egy_bus/features/driver_login/data/repo/driver_login_repo.dart';
import 'package:egy_bus/features/driver_login/logic/cubit/driver_login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverLoginCubit extends Cubit<DriverLoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final DriverLoginRepo _driverLoginRepo;

  DriverLoginCubit(this._driverLoginRepo)
      : super(const DriverLoginState.initial());

  void emitDriverLogin() async {
    emit(const DriverLoginState.loading());

    final response = await _driverLoginRepo.driverLogin(DriverLoginRequest(
      password: passwordController.text,
      username: userNameController.text,
    ));
    response.when(success: (data)async {
     await cacheDriverId(data);
      emit(DriverLoginState.signUpSuccess(driverLoginResponse: data));
    }, failure: (failure) {
      emit(DriverLoginState.signUpFailure(apiError: failure));
    });
  }
Future<void> cacheDriverId(DriverLoginResponse data)async{
     AppSharedPref.sharedPrefSet(key: AppSharedPrefKey.driverUserId, value: data.userId);
     driverUserId=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverUserId);
}
}
