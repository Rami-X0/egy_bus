import 'dart:ui';

import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/widgets/app_blur_dialog.dart';
import 'package:egy_bus/core/widgets/app_loading.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_cubit.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListenerPassengerLogin extends StatelessWidget {
  const BlocListenerPassengerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PassengerLoginCubit, PassengerLoginState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const AppBlurDialog(
                  child: AppLoading(),
                );
              },
            );
          },
          signUpSuccess: (data) {
            context.pushNamedAndRemoveUntil(Routes.passengerStationLink);
          },
          signUpFailure: (failure) {
            context.pop();
            setupErrorState(context, 'Please try later');
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}

void setupErrorState(BuildContext context, String failure) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          failure.toString(),
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Got it',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ),
  );
}
