import 'package:dio/dio.dart';
import 'package:egy_bus/features/driver_login/data/models/driver_login_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "driver_login_state.freezed.dart";

@freezed
class DriverLoginState with _$DriverLoginState {
  const factory DriverLoginState.initial() = _Initial;

  const factory DriverLoginState.loading() = Loading;

  const factory DriverLoginState.signUpSuccess(
  {
    required DriverLoginResponse driverLoginResponse
}
  ) = LoginSuccess;

  const factory DriverLoginState.signUpFailure(
      {required DioException apiError}) = LoginFailure;


}
