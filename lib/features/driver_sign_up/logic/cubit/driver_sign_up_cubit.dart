import 'package:egy_bus/features/driver_sign_up/data/models/driver_sign_up_request.dart';
import 'package:egy_bus/features/driver_sign_up/data/repo/driver_sign_up_repo.dart';
import 'package:egy_bus/features/driver_sign_up/logic/cubit/driver_sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverSignUpCubit extends Cubit<DriverSignUpState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final DriverSignUpRepo _driverSignUpRepo;

  DriverSignUpCubit(this._driverSignUpRepo)
      : super(const DriverSignUpState.initial());

  void emitDriverSignUp() async {
    emit(const DriverSignUpState.loading());

    final response = await _driverSignUpRepo.driverSignUp(DriverSignUpRequest(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
      username: userNameController.text,
      phoneNumber: numberController.text,
    ));
    response.when(success: (data) {
      emit(const DriverSignUpState.signUpSuccess());
    }, failure: (failure) {
      emit(DriverSignUpState.signUpFailure(apiError: failure));
    });
  }
}
