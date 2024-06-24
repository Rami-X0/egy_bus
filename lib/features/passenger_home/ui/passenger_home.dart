import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_loading.dart';
import 'package:egy_bus/core/widgets/app_snack_bar.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_state.dart';
import 'package:egy_bus/features/passenger_home/ui/all_book_screen.dart';
import 'package:egy_bus/features/passenger_home/ui/station_trip_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<PassengerHomeCubit>().emitAllTrip();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Passenger Home',
            style: TextStyles.font15DarkBlueMedium.copyWith(
              color: ColorsManager.mainColor,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AllBookScreen()));
              },
              child: const Text(
                'My Book',
                style: TextStyle(color: Color(0xff00ADCF)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0.h,
                vertical: 15.h,
              ),
              child: InkWell(
                onTap: () {
                  context.pushNamed(Routes.passengerProfile);
                },
                child: FaIcon(
                  FontAwesomeIcons.solidCircleUser,
                  color: ColorsManager.mainColor,
                  size: 28.w,
                ),
              ),
            ),
          ]),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: BlocBuilder<PassengerHomeCubit, PassengerHomeState>(
            buildWhen: (previous, current) =>
                current is AllTripsLoading || current is AllTripsSuccess,
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => Container(),
                  allTripsLoading: () {
                    return const AppLoading();
                  },
                  allTripsSuccess: (data) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          Gap(data[index].availableSeats == 0 ? 0 : 15.h),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (_) => StationTripItem(
                            //           data: data[index],
                            //         )));
                          },
                          child: Visibility(
                            visible: data[index].availableSeats != 0,
                            child: Container(
                              height: 261.h,
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
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data[index].fromStationName,
                                            style: TextStyles
                                                .font15DarkBlueMedium
                                                .copyWith(
                                                    color: const Color(
                                                        0xff003D48)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          child: Text(
                                            data[index].toStationName,
                                            style: TextStyles
                                                .font15DarkBlueMedium
                                                .copyWith(
                                                    color: const Color(
                                                        0xff003D48)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(10.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
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
                                          'Available Seats',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(10.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Live now',
                                          style: TextStyle(
                                              color: Color(0xff666666)),
                                        ),
                                        const Spacer(),
                                        Text(data[index]
                                            .availableSeats
                                            .toString())
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 7.w,
                                        backgroundColor:
                                            const Color(0xffB0E6F0),
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
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
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
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
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
                                        backgroundColor:
                                            const Color(0xffB0E6F0),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              const Color(0xffE6F7FA),
                                          maxRadius: 5.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(data[index].busPlate),
                                  Container(
                                    width: double.maxFinite,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.r),
                                          bottomRight: Radius.circular(15.r),
                                        ),
                                        color: const Color(0xffE6F7FA)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${data[index].price.toString().replaceAll('.0', '')} EGp',
                                            style: TextStyles
                                                .font15DarkBlueMedium
                                                .copyWith(
                                                    color: const Color(
                                                        0xff00ADCF)),
                                          ),
                                          const Spacer(),
                                          BlocBuilder<PassengerHomeCubit,
                                              PassengerHomeState>(
                                            builder: (context, state) {
                                              bool isLoading = state
                                                      is PassengerBooKTripLoading &&
                                                  state.index == index;
                                              return AppTextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          StationTripItem(
                                                        data: data[index],
                                                      ),
                                                    ),
                                                  );
                                                  appSnackBar(
                                                      text: 'Book Trip Success',
                                                      backGroundColor:
                                                          Colors.green,
                                                      context: context);
                                                },
                                                text: isLoading
                                                    ? 'Loading...'
                                                    : 'Book Trip',
                                                textStyle: TextStyles
                                                    .font28WhiteSemiBold
                                                    .copyWith(
                                                  fontSize: 15.sp,
                                                ),
                                                verticalSize: 15,
                                                horizontalSize: 180,
                                                border: 5,
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

class BookCompletedScreen extends StatelessWidget {
  const BookCompletedScreen({super.key});

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
                'Book Completed Successfully',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff003D48),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'This book has been completed successfully and here we generated your stats',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 200.0.h),
              AppTextButton(
                onPressed: () {
                  context.pop();
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
