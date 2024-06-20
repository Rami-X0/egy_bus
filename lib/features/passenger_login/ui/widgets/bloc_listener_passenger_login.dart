import 'dart:ui';

import 'package:egy_bus/core/di/dependency_injection.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_blur_dialog.dart';
import 'package:egy_bus/core/widgets/app_loading.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_state.dart';
import 'package:egy_bus/features/passenger_home/ui/station_link_screen.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_cubit.dart';
import 'package:egy_bus/features/passenger_login/logic/cubit/passenger_login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
            context
                .read<PassengerHomeCubit>()
                .emitPassengerStationLink()
                .then((value) {
              showModalBottomSheet(
                  useRootNavigator: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return _buildBottomSheetStationLink(context);
                  });
            });
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
Widget _buildBottomSheetStationLink(BuildContext context) {
  context.read<PassengerHomeCubit>().getPermissionLocation(context);

  context.read<PassengerHomeCubit>().emitBusLineResponse();
  return BlocProvider.value(
    value: getIt<PassengerHomeCubit>(),
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 700.h,
          alignment: Alignment.topCenter,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 150.w, vertical: 10.h),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 5.0,
                  decoration: const BoxDecoration(
                    color: ColorsManager.mainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<PassengerHomeCubit, PassengerHomeState>(
                  buildWhen: (previous, current) =>
                  current is GetStationLineLoading ||
                      current is GetBusLineSuccess ||
                      current is GetStationLineFailure,
                  builder: (context, state) {
                    return state.maybeWhen(
                        orElse: () => Container(),
                        getStationLineLoading: () {
                          return const AppLoading();
                        },
                        getBusLineSuccess: (data) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From (Current Station)',
                                  style: TextStyles.font15DarkBlueMedium,
                                ),
                                RadioList(
                                  data: data,
                                  isSelectActionMethod: true,
                                ),
                                const Divider(),
                                Text(
                                  'To (Destination Station)',
                                  style: TextStyles.font15DarkBlueMedium,
                                ),
                                RadioList(
                                  data: data,
                                  isSelectActionMethod: false,
                                ),
                                Gap(25.h),
                                BlocBuilder<PassengerHomeCubit,
                                    PassengerHomeState>(
                                  builder: (context, state) {
                                    return AppTextButton(
                                      onPressed: () {
                                        // context
                                        //     .read<PassengerHomeCubit>()
                                        //     .emitAddBook(0)
                                        //     .then((onValue) {
                                        context.pushNamedAndRemoveUntil(
                                            Routes.passengerHome);
                                        // });
                                      },
                                      text: state is AddBookLoading
                                          ? 'Wait...'
                                          : 'Confirm',
                                      textStyle: TextStyles
                                          .font28WhiteSemiBold
                                          .copyWith(
                                        fontSize: 15.sp,
                                      ),
                                      backGroundColor:
                                           ColorsManager.mainColor,
                                      verticalSize: 55,
                                      border: 5,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        getStationLineFailure: (failure) {
                          if (failure.response!.statusCode == 500) {
                            return const Text('The code is incorrect');
                          } else {
                            return Text(failure.toString());
                          }
                        });
                  },
                ),
              )
            ],
          ),
        )),
  );
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
