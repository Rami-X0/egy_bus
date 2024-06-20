import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "passenger_sign_up_state.freezed.dart";

@freezed
class PassengerSignUpState with _$PassengerSignUpState {
  const factory PassengerSignUpState.initial() = _Initial;

  const factory PassengerSignUpState.loading() = Loading;

  const factory PassengerSignUpState.signUpSuccess(
  ) = LoginSuccess;

  const factory PassengerSignUpState.signUpFailure(
      {required DioException apiError}) = LoginFailure;


}
