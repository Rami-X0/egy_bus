import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_loading.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_cubit.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_state.dart';
import 'package:egy_bus/features/driver_home/ui/widgets/trip/add_trip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DriverHomeCubit>().emitAllTrip();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Driver Home',
          style: TextStyles.font15DarkBlueMedium.copyWith(
            color: ColorsManager.mainColor,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0.h,
            vertical: 15.h,
          ),
          child: InkWell(
            onTap: () {
              context.pushNamed(Routes.chooseUser);
              AppSharedPref.removeKey(key: AppSharedPrefKey.driverUserId);
              AppSharedPref.removeKey(key: AppSharedPrefKey.driverIdFrom);
              AppSharedPref.removeKey(key: AppSharedPrefKey.driverIdTo);
            },
            child: FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: ColorsManager.mainColor,
              size: 20.w,
            ),
          ),
        ),
        actions: [
          AddTripButton(),
          IconButton(
            onPressed: () {
              context.read<DriverHomeCubit>().emitAllTrip();
            },
            icon: Icon(Icons.refresh),
            color: ColorsManager.mainColor,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: BlocBuilder<DriverHomeCubit, DriverHomeState>(
            buildWhen: (previous, current) =>
                current is AllTripsLoading ||
                current is DeleteTripsLoading ||
                current is AllTripsSuccess ||
                current is DeleteTripsSuccess ||
                current is DeleteTripsFailure ||
                current is AllTripsFailure,
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => Container(),
                  allTripsLoading: () {
                    return const AppLoading();
                  },
                  deleteTripsLoading: () {
                    return const AppLoading();
                  },
                  allTripsSuccess: (data) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Gap(data[index].availableSeats == 0?0:15.h),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Visibility(
                          visible:
                              data[index].availableSeats == 0 ? false : true,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            height: 245.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Stack(
                                    children: [
                                      Text(
                                        'Station Link ',
                                        style: TextStyles.font15DarkBlueMedium
                                            .copyWith(
                                          fontSize: 20.sp,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 2.8
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Station Link ',
                                        style: TextStyles.font15DarkBlueMedium
                                            .copyWith(
                                          fontSize: 20.sp,
                                          color: ColorsManager.mainColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data[index].fromStationName,
                                        style: TextStyles.font15DarkBlueMedium
                                            .copyWith(
                                                color: const Color(0xff003D48)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      child: Text(
                                        data[index].toStationName,
                                        style: TextStyles.font15DarkBlueMedium
                                            .copyWith(
                                                color: const Color(0xff003D48)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(10.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Status',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Gap(5.w),
                                      CircleAvatar(
                                        maxRadius: 7.w,
                                        backgroundColor: Colors.grey,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.greenAccent,
                                          maxRadius: 5.w,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        'Available State',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(10.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Live now',
                                        style:
                                            TextStyle(color: Color(0xff666666)),
                                      ),
                                      const Spacer(),
                                      Text(
                                          data[index].availableSeats.toString())
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 7.w,
                                      backgroundColor: const Color(0xffB0E6F0),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff00ADCF),
                                        maxRadius: 5.w,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        12,
                                        (index) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Container(
                                            color: Colors.blue,
                                            height: 2,
                                            width: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.train,
                                      color: Colors.blue,
                                    ),
                                    Row(
                                      children: List.generate(
                                        12,
                                        (index) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Container(
                                            color: Colors.blue,
                                            height: 2,
                                            width: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      maxRadius: 7.w,
                                      backgroundColor: const Color(0xffB0E6F0),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            const Color(0xffE6F7FA),
                                        maxRadius: 5.w,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(data[index].busPlate),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: AppTextButton(
                                    onPressed: () {
                                      context
                                          .read<DriverHomeCubit>()
                                          .emitDeleteTrip(data[index].id);
                                    },
                                    border: 5,
                                    verticalSize: 30,
                                    horizontalSize: 100,
                                    text: "cancel",
                                    textStyle: TextStyles.font11BlackMedium
                                        .copyWith(
                                            color: ColorsManager.white,
                                            fontSize: 15.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  allTripsFailure: (failure) {
                    return Text(failure.message.toString());
                  });
            },
          ),
        ),
      ),
    );
  }
}
