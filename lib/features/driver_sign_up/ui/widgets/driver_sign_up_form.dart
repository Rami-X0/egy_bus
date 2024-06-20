import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/widgets/app_text_form_field.dart';
import 'package:egy_bus/features/driver_sign_up/logic/cubit/driver_sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class DriverSignUpForm extends StatefulWidget {
  const DriverSignUpForm({super.key});

  @override
  State<DriverSignUpForm> createState() => _DriverSignUpFormState();
}

class _DriverSignUpFormState extends State<DriverSignUpForm> {
  bool _showPassword = true;
  bool iaFullNameColorFailureIcon = false;
  bool isUserNameColorFailureIcon = false;
  bool iEmailColorFailureIcon = false;
  bool isPasswordColorFailureIcon = false;
  bool isNumberColorFailureIcon = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<DriverSignUpCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            textTopFailed: 'Full Name',
            keyboardType: TextInputType.text,
            controller: context.read<DriverSignUpCubit>().fullNameController,
            hintText: 'Enter your full name',
            validator: (value) {
              return validateFullName(value);
            },
          ),
          Gap(16.h),
          AppTextFormField(
            textTopFailed: 'User Name',
            keyboardType: TextInputType.text,
            controller: context.read<DriverSignUpCubit>().userNameController,
            hintText: 'Enter your user name',
            validator: (value) {
              return validateUserName(value);
            },
          ),
          Gap(16.h),
          AppTextFormField(
            textTopFailed: 'Email',
            keyboardType: TextInputType.emailAddress,
            controller: context.read<DriverSignUpCubit>().emailController,
            hintText: 'Enter your email',
            validator: (value) {
              return validateEmail(value);
            },
          ),
          Gap(16.h),
          AppTextFormField(
            textTopFailed: 'Number',
            keyboardType: TextInputType.number,
            controller: context.read<DriverSignUpCubit>().numberController,
            hintText: 'Enter your Number',
            validator: (value) {
              return validateNumber(value);
            },
          ),
          Gap(16.h),
          AppTextFormField(
            textTopFailed: 'Password',
            keyboardType: TextInputType.visiblePassword,
            controller: context.read<DriverSignUpCubit>().passwordController,
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        iEmailColorFailureIcon = true;
      });
      return 'Please enter your user email';
    } else {
      setState(() {
        iEmailColorFailureIcon = false;
      });
    }
    return null;
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

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        iaFullNameColorFailureIcon = true;
      });
      return 'Please enter full name';
    } else {
      setState(() {
        iaFullNameColorFailureIcon = false;
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
  }String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isNumberColorFailureIcon = true;
      });
      return 'Please enter number';
    } else {
      setState(() {
        isNumberColorFailureIcon = false;
      });
    }
    return null;
  }
}
