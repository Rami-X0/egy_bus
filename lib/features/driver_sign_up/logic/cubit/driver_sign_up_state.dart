import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "driver_sign_up_state.freezed.dart";

@freezed
class DriverSignUpState with _$DriverSignUpState {
  const factory DriverSignUpState.initial() = _Initial;

  const factory DriverSignUpState.loading() = Loading;

  const factory DriverSignUpState.signUpSuccess(
  ) = LoginSuccess;

  const factory DriverSignUpState.signUpFailure(
      {required DioException apiError}) = LoginFailure;


}
