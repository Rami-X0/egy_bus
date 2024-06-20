import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/di/dependency_injection.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_loading.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/core/widgets/app_text_form_field.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_station_link_response.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PassengerStationLinkScreen extends StatefulWidget {
  const PassengerStationLinkScreen({super.key});

  @override
  State<PassengerStationLinkScreen> createState() =>
      _PassengerStationLinkScreenState();
}

bool isStationLikColorFailureIcon = false;
bool _isButtonActive = false;

class _PassengerStationLinkScreenState
    extends State<PassengerStationLinkScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<PassengerHomeCubit>()
        .getPermissionLocation(context)
        .then((onValue) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6F7FA),
      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Text(
                      'Station Link ',
                      style: TextStyles.font15DarkBlueMedium.copyWith(
                        fontSize: 30.sp,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2.8
                          ..color = Colors.black,
                      ),
                    ),
                    Text(
                      'Station Link ',
                      style: TextStyles.font15DarkBlueMedium.copyWith(
                        fontSize: 30.sp,
                        color: ColorsManager.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(60.h),
              Container(
                width: 325.w,
                height: 256.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      Gap(25.h),
                      _formStationLink(),
                      Gap(20.h),
                      _textButtonAddLinkCode(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formStationLink() {
    return AppTextFormField(
      textTopFailed: 'Link Code',
      keyboardType: TextInputType.text,
      controller: context.read<PassengerHomeCubit>().stationLinkController,
      hintText: 'Enter your Link Code',
      onChanged: (value) {
        if (value.length >= 2) {
          setState(() {
            _isButtonActive = true;
          });
        } else {
          setState(() {
            _isButtonActive = false;
          });
        }
      },
      validator: (value) {
        return validateStationLink(value);
      },
    );
  }

  Widget _textButtonAddLinkCode() {
    return BlocBuilder<PassengerHomeCubit, PassengerHomeState>(
      builder: (context, state) {
        return AppTextButton(
          onPressed: _isButtonActive
              ? () {
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
                }
              : null,
          text: state is GetStationPassengerLineLoading ? 'Wait...' : 'Confirm',
          textStyle: TextStyles.font28WhiteSemiBold.copyWith(
            fontSize: 15.sp,
          ),
          backGroundColor:
              _isButtonActive ? ColorsManager.mainColor : ColorsManager.grey,
          verticalSize: 55,
          border: 5,
        );
      },
    );
  }

  Widget _buildBottomSheetStationLink(BuildContext context) {
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
                        current is GetStationPassengerLineLoading ||
                        current is GetStationLineSuccess ||
                        current is GetStationLineFailure,
                    builder: (context, state) {
                      return state.maybeWhen(
                          orElse: () => Container(),
                          getStationPassengerLineLoading: () {
                            return const AppLoading();
                          },
                          getStationLineSuccess: (data) {
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
                                        backGroundColor: _isButtonActive
                                            ? ColorsManager.mainColor
                                            : ColorsManager.grey,
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

  String? validateStationLink(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isStationLikColorFailureIcon = true;
      });
      return 'Please enter your password';
    } else {
      setState(() {
        isStationLikColorFailureIcon = false;
      });
    }
    return null;
  }
}

class RadioList extends StatefulWidget {
  final List<DriverStationLinkResponse> data;
  final bool isSelectActionMethod;

  const RadioList(
      {super.key, required this.data, required this.isSelectActionMethod});

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PassengerHomeCubit>();
    if (stationLong == null || stationLat == null) {
      setState(() {
        context.read<PassengerHomeCubit>().stationLon =
            widget.data[1].stationLong;
        context.read<PassengerHomeCubit>().stationLa =
            widget.data[1].stationLat;
      });
    }
    return Expanded(
      flex: 1,
      child: ListView.separated(
        itemCount: widget.data.length,
        itemBuilder: (_, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _defaultRadio(
                  title: widget.data[index].name,
                  value: index,
                  groupValue: currentIndex,
                  onChanged: (value) {
                    widget.isSelectActionMethod
                        ? setState(() {
                            AppSharedPref.removeKey(
                                key: AppSharedPrefKey.passengerIdFrom);
                            AppSharedPref.removeKey(
                                key: AppSharedPrefKey.passengerLong);
                            AppSharedPref.removeKey(
                                key: AppSharedPrefKey.passengerLat);
                            AppSharedPref.sharedPrefSet(
                                key: AppSharedPrefKey.passengerIdFrom,
                                value: widget.data[index].id);
                            AppSharedPref.sharedPrefSet(
                                key: AppSharedPrefKey.stationLong,
                                value: widget.data[index].stationLong);
                            AppSharedPref.sharedPrefSet(
                                key: AppSharedPrefKey.stationLat,
                                value: widget.data[index].stationLat);
                            cubit.stationIdFrom = widget.data[index].id;
                            currentIndex = index;
                          })
                        : setState(() {
                            AppSharedPref.removeKey(
                                key: AppSharedPrefKey.passengerIdTo);

                            AppSharedPref.sharedPrefSet(
                                key: AppSharedPrefKey.passengerIdTo,
                                value: widget.data[index].id);

                            cubit.stationIdTo = widget.data[index].id;
                            currentIndex = index;
                          });
                    debugPrint(cubit.stationIdFrom.toString());
                    debugPrint(cubit.stationIdTo.toString());
                  }),
            ],
          );
        },
        separatorBuilder: (_, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _defaultRadio({
    required String title,
    required dynamic value,
    required dynamic groupValue,
    required void Function(dynamic)? onChanged,
  }) {
    return Row(
      children: [
        Radio(
          fillColor: WidgetStateProperty.all(ColorsManager.mainColor),
          overlayColor: WidgetStateProperty.all(ColorsManager.lightGray),
          value: value,
          onChanged: onChanged,
          groupValue: groupValue,
        ),
        Text(
          title,
          style: TextStyles.font28WhiteSemiBold
              .copyWith(fontSize: 15.sp, color: Colors.black),
        ),
      ],
    );
  }
}
