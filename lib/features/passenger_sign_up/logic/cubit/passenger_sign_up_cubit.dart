
import 'package:egy_bus/features/passenger_sign_up/data/models/passenger_sign_up_request.dart';
import 'package:egy_bus/features/passenger_sign_up/data/repo/passenger_sign_up_repo.dart';
import 'package:egy_bus/features/passenger_sign_up/logic/cubit/passenger_sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerSignUpCubit extends Cubit<PassengerSignUpState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final PassengerSignUpRepo _passengerSignUpRepo;

  PassengerSignUpCubit(this._passengerSignUpRepo)
      : super(const PassengerSignUpState.initial());

  void emitPassengerSignUp() async {
    emit(const PassengerSignUpState.loading());

    final response = await _passengerSignUpRepo.passengerSignUp(PassengerSignUpRequest(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
      username: userNameController.text,
      phoneNumber: numberController.text,
    ));
    response.when(success: (data) {
      emit(const PassengerSignUpState.signUpSuccess());
    }, failure: (failure) {
      emit(PassengerSignUpState.signUpFailure(apiError: failure));
    });
  }
}
