import 'package:egy_bus/core/di/dependency_injection.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_blur_dialog.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_cubit.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_state.dart';
import 'package:egy_bus/features/driver_home/ui/widgets/trip/form_driver_add_trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddTripButton extends StatelessWidget {
  const AddTripButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<DriverHomeCubit>(),
      child: TextButton(
        onPressed: () => actionThenTapAddTrip(context),
        child: Text(
          'Add Trip',
          style: TextStyles.font15DarkBlueMedium
              .copyWith(color: ColorsManager.mainColor),
        ),
      ),
    );
  }

  void actionThenTapAddTrip(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
      builder: (context) {
        return BlocProvider.value(
          value: getIt<DriverHomeCubit>(),
          child: AppBlurDialog(child: _buildDialogAddTrip(context)),
        );
      },
    );
  }

  Widget _buildDialogAddTrip(BuildContext context) {
    return BlocProvider.value(
      value: getIt<DriverHomeCubit>(),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          width: double.maxFinite,
          color: Colors.white,
          height: 500.h,
          child: Column(
            children: [
              const CloseButton(),
              const FormDriverAddTrip(),
              Gap(40.h),
              _addTrip(context),
            ],
          ),
        ),
      ),
    );
  }

  void actionTapClose(BuildContext context) {
    final cubit = context.read<DriverHomeCubit>();
    // context.pop();
    cubit.priceTripController.clear();
    cubit.busPlateController.clear();
    cubit.availableSeatsTripController.clear();
  }

  Widget _addTrip(BuildContext context) {
    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        return AppTextButton(
          onPressed: () => actionTapButtonLogin(context),
          text: state is AddTripsLoading ? 'Loading...' : 'Done',
          textStyle: TextStyles.font28WhiteSemiBold,
          verticalSize: 25,
          border: 5,
        );
      },
    );
  }

  actionTapButtonLogin(BuildContext context) {
    final cubit = context.read<DriverHomeCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.emitAddTrip().then(
        (value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const TripCompletedScreen()));
          context.read<DriverHomeCubit>().emitAllTrip();
          actionTapClose(context);
        },
      );
    }
  }
}

class TripCompletedScreen extends StatelessWidget {
  const TripCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff00ADCF),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Icon(
                  Icons.check,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Trip Completed Successfully',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff003D48),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'This trip has been completed successfully and here we generated your stats',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 200.0.h),
              AppTextButton(
                onPressed: () {
                  context.pushNamedAndRemoveUntil(Routes.driverHome);
                context.read<DriverHomeCubit>().emitAllTrip();
                  },
                text: 'Go Back',
                textStyle: TextStyles.font28WhiteSemiBold.copyWith(
                  fontSize: 18.sp,
                ),
                border: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
