import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/features/passenger_login/data/models/passenger_login_request.dart';
import 'package:egy_bus/features/passenger_login/data/models/passenger_login_response.dart';
import 'package:egy_bus/features/passenger_login/data/repo/passenger_login_repo.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerLoginCubit extends Cubit<PassengerLoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final PassengerLoginRepo _passengerLoginRepo;

  PassengerLoginCubit(this._passengerLoginRepo)
      : super(const PassengerLoginState.initial());

  void emitPassengerLogin() async {
    emit(const PassengerLoginState.loading());

    final response =
        await _passengerLoginRepo.driverLogin(PassengerLoginRequest(
      password: passwordController.text,
      username: userNameController.text,
    ));
    response.when(success: (data) {
      cachePassengerId(data);
      emit(PassengerLoginState.signUpSuccess(driverLoginResponse: data));
    }, failure: (failure) {
      emit(PassengerLoginState.signUpFailure(apiError: failure));
    });
  }

  Future<void> cachePassengerId(PassengerLoginResponse data) async {
    AppSharedPref.sharedPrefSet(
        key: AppSharedPrefKey.passengerUserId, value: data.userId);
    passengerUserId = await AppSharedPref.sharedPrefGet(
        key: AppSharedPrefKey.passengerUserId);
  }
}
