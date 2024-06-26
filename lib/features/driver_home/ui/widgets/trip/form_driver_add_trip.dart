import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/widgets/app_text_form_field.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class FormDriverAddTrip extends StatefulWidget {
  const FormDriverAddTrip({super.key});

  @override
  State<FormDriverAddTrip> createState() => _FormDriverAddTripState();
}

bool isBusPlateTripColorFailureIcon = false;
bool isPriceTripColorFailureIcon = false;
bool isAvailableStatsTripColorFailureIcon = false;

class _FormDriverAddTripState extends State<FormDriverAddTrip> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<DriverHomeCubit>().formKey,
      child: Column(
        children: [
          Gap(20.h),
          AppTextFormField(
            keyboardType: TextInputType.text,
            controller: context.read<DriverHomeCubit>().busPlateController,
            hintText: 'bus plate',
            suffixIcon: FaIcon(
              FontAwesomeIcons.caravan,
              color: isBusPlateTripColorFailureIcon ? Colors.red : ColorsManager.mainColor,
            ),
            validator: (value) {
              return validateBusPlate(value);
            },
          ),
          Gap(20.h),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppTextFormField(
                  keyboardType: TextInputType.number,
                  controller: context.read<DriverHomeCubit>().priceTripController,
                  hintText: 'price',
                  suffixIcon: FaIcon(
                    FontAwesomeIcons.barcode,
                    color: isPriceTripColorFailureIcon ? Colors.red : ColorsManager.mainColor,
                  ),
                  validator: (value) {
                    return validateTripPrice(value);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              Gap(2.w),
              Flexible(
                flex: 1,
                child: AppTextFormField(
                  // hintTextSize: 11.sp,
                  keyboardType: TextInputType.number,
                  controller: context.read<DriverHomeCubit>().availableSeatsTripController,
                  hintText: 'available',
                  suffixIcon: FaIcon(
                    FontAwesomeIcons.chalkboard,
                    color: isAvailableStatsTripColorFailureIcon ? Colors.red : ColorsManager.mainColor,
                  ),
                  validator: (value) {
                    return validateAvailableStats(value);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? validateTripPrice(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isPriceTripColorFailureIcon = true;
      });
      return 'Please enter a number';
    }
    final number = int.tryParse(value);
    if (number == null) {
      setState(() {
        isPriceTripColorFailureIcon = true;
      });
      return 'Please enter a valid number';
    }

    return null;
  }

  String? validateBusPlate(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isBusPlateTripColorFailureIcon = true;
      });
      return 'enter bus plate';
    } else {
      setState(() {
        isBusPlateTripColorFailureIcon = false;
      });
    }
    return null;
  }

  String? validateAvailableStats(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isAvailableStatsTripColorFailureIcon = true;
      });
      return 'enter available state';
    }
    final number = int.tryParse(value);
    if (number == null) {
      setState(() {
        isAvailableStatsTripColorFailureIcon = true;
      });
      return 'Please enter a valid number';
    }
    if (number < 1 || number > 14) {
      setState(() {
        isAvailableStatsTripColorFailureIcon = true;
      });
      return 'Number must be between 1 and 14';
    }
    setState(() {
      isAvailableStatsTripColorFailureIcon = false;
    });
    return null;
  }
}
