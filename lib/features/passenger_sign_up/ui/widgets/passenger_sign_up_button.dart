import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/features/passenger_sign_up/logic/cubit/passenger_sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PassengerSignUpButton extends StatelessWidget {
  const PassengerSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      onPressed: () => actionTapButtonLogin(context),
      text: 'Sign Up',
      textStyle: TextStyles.font28WhiteSemiBold.copyWith(fontSize: 18.sp),
      border: 5,
      verticalSize: 50,
    );
  }

  void actionTapButtonLogin(BuildContext context) {
    final cubit = context.read<PassengerSignUpCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.emitPassengerSignUp();
    }
  }
}
