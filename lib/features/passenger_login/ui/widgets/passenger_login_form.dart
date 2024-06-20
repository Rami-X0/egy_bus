import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/widgets/app_text_form_field.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class PassengerLoginForm extends StatefulWidget {
  const PassengerLoginForm({super.key});

  @override
  State<PassengerLoginForm> createState() => _PassengerLoginFormState();
}

class _PassengerLoginFormState extends State<PassengerLoginForm> {
  bool _showPassword = true;
  bool isUserNameColorFailureIcon = false;
  bool isPasswordColorFailureIcon = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<PassengerLoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            textTopFailed: 'User Name',
            keyboardType: TextInputType.text,
            controller: context.read<PassengerLoginCubit>().userNameController,
            hintText: 'Enter your user name',
            validator: (value) {
              return validateUserName(value);
            },
          ),
          Gap(16.h),
          AppTextFormField(
            textTopFailed: 'Password',
            keyboardType: TextInputType.visiblePassword,
            controller: context.read<PassengerLoginCubit>().passwordController,
            hintText: ' Enter your password',
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              child: FaIcon(
                _showPassword
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye,
                color: isPasswordColorFailureIcon
                    ? Colors.red
                    : ColorsManager.darkBlue,
              ),
            ),
            obscureText: _showPassword,
            validator: (value) {
              return validatePassword(value);
            },
          ),
        ],
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isPasswordColorFailureIcon = true;
      });
      return 'Please enter your password';
    } else if (value.length < 8) {
      setState(() {
        isPasswordColorFailureIcon = true;
      });
      return 'Password must be at least 8 characters';
    } else {
      setState(() {
        isPasswordColorFailureIcon = false;
      });
    }
    return null;
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isUserNameColorFailureIcon = true;
      });
      return 'Please enter user name';
    } else {
      setState(() {
        isUserNameColorFailureIcon = false;
      });
    }
    return null;
  }
}
