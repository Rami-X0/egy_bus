import 'package:dio/dio.dart';
import 'package:egy_bus/features/passenger_login/data/models/passenger_login_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "passenger_login_state.freezed.dart";

@freezed
class PassengerLoginState with _$PassengerLoginState {
  const factory PassengerLoginState.initial() = _Initial;

  const factory PassengerLoginState.loading() = Loading;

  const factory PassengerLoginState.signUpSuccess(
  {
    required PassengerLoginResponse driverLoginResponse
}
  ) = LoginSuccess;

  const factory PassengerLoginState.signUpFailure(
      {required DioException apiError}) = LoginFailure;


}
