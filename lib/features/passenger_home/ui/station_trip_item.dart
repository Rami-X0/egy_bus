import 'dart:async';

import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/features/driver_home/data/models/all_trip_response.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class StationTripItem extends StatefulWidget {
  final AllTripResponse data;

  const StationTripItem({super.key, required this.data});

  @override
  State<StationTripItem> createState() => _StationTripItemState();
}

Timer? _timer;
int _start = 120;

class _StationTripItemState extends State<StationTripItem> {
  @override
  void initState() {
    super.initState();
    context.read<PassengerHomeCubit>().totalValue = widget.data.price;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        context.pop();
        _start = 120;

        context.read<PassengerHomeCubit>().emitAllTrip();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String get timerText {
    final minutes = _start ~/ 60;
    final seconds = _start % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(passengerName.toString()),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Row(
          children: [
            BackButton(
              onPressed: () {
                context.pop();
                setState(() {
                  _start = 120;
                  context.read<PassengerHomeCubit>().counter = 1;
                  context.read<PassengerHomeCubit>().totalValue = 0;
                });
                context.read<PassengerHomeCubit>().emitAllTrip();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 15.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Text('Arrived:${timerText.toString()}',style: TextStyles.font15DarkBlueMedium,),

                        Container(
                          width: 50.0.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(
                            Icons.directions_bus,
                            size: 30.0.w,
                            color: const Color(0xffB0E6F0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      'Reservation Bus Ticket',
                      style: TextStyle(
                        fontSize: 18.0.sp,
                        color: const Color(0xff666666),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Time :'),
                        Gap(8.0.w),
                        Text(
                          DateTime.now().toIso8601String().substring(0, 16),
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            color: const Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_bus,
                                size: 25.0.w,
                                color: const Color(0xffB0E6F0),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trip ID',
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4.0.h),
                                  Text(
                                    widget.data.id.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0.sp,
                                      color: const Color(0xff0B4550),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.data.fromStationName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff0B4550),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.data.toStationName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff0B4550),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0.h),
                    Row(
                      children: List.generate(
                        32,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            color: Colors.grey,
                            height: 2,
                            width: 5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Passenger Name',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4.0.h),
                                Text(
                                  passengerName,
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Plate Number',
                                style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                widget.data.busPlate,
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    SizedBox(height: 16.0.h),
                    Container(
                      height: 85.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffB0E6F0),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0.r),
                          bottomRight: Radius.circular(16.0.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '#${widget.data.id}965187',
                            style: TextStyle(
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.barcode,
                              ),
                              FaIcon(
                                FontAwesomeIcons.barcode,
                              ),
                              FaIcon(
                                FontAwesomeIcons.barcode,
                              ),
                              FaIcon(
                                FontAwesomeIcons.barcode,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0.h),
              Counter(data: widget.data),
              SizedBox(height: 16.0.h),
              Text(
                'cach Methods',
                style: TextStyles.font60MainColorBold
                    .copyWith(fontSize: 30.sp, color: ColorsManager.darkBlue),
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.coins),
                  Gap(18.w),
                  Text(
                    'cash ',
                    style: TextStyles.font60MainColorBold.copyWith(
                        fontSize: 18.sp, color: ColorsManager.darkBlue),
                  ),
                ],
              ),
              SizedBox(height: 16.0.h),
              Container(
                width: double.maxFinite,
                height: 130.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(1, 3),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'I agree on Terms and Conditions of\n Station Link',
                      style: TextStyles.font15DarkBlueMedium,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<PassengerHomeCubit>()
                            .emitPassengerPayment()
                            .then((onValue) {
                          setState(() {
                            context.read<PassengerHomeCubit>().counter = 1;
                            context.read<PassengerHomeCubit>().totalValue =
                                widget.data.price;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  const TripPassengerCompletedScreen()));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300.w, 60.h),
                        backgroundColor: const Color(0xff00ADCF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                      ),
                      label: const Text(
                        'Check Out',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(15.h)
            ],
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  final AllTripResponse data;

  const Counter({super.key, required this.data});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          height: 55.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(1, 3),
                    spreadRadius: 1)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Icon(
                  Icons.supervised_user_circle_sharp,
                  color: Colors.grey,
                  size: 25.w,
                ),
                Gap(15.w),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (context.read<PassengerHomeCubit>().counter > 1) {
                          context.read<PassengerHomeCubit>().counter--;
                          context.read<PassengerHomeCubit>().totalValue =
                              context.read<PassengerHomeCubit>().totalValue! -
                                  widget.data.price;
                        }
                      });
                    },
                    icon: Icon(Icons.remove, color: Colors.grey, size: 25.w)),
                Text(
                  context.read<PassengerHomeCubit>().counter.toString(),
                  style: TextStyles.font15DarkBlueMedium,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (context.read<PassengerHomeCubit>().counter < 14) {
                          context.read<PassengerHomeCubit>().counter++;
                          context.read<PassengerHomeCubit>().totalValue =
                              widget.data.price *
                                  context.read<PassengerHomeCubit>().counter;
                        }
                      });
                    },
                    icon: Icon(Icons.add, color: Colors.grey, size: 25.w)),
              ],
            ),
          ),
        ),
        Gap(15.h),
        Container(
          width: double.maxFinite,
          height: 75.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(1, 3),
                    spreadRadius: 1)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.grey,
                  size: 25.w,
                ),
                Gap(20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ticket Value:${widget.data.price.toString().replaceAll('.0', '')} EGP',
                      style: TextStyles.font15DarkBlueMedium,
                    ),
                    Text(
                        'Total Amount:${context.watch<PassengerHomeCubit>().totalValue ?? widget.data.price}',
                        style: TextStyles.font15DarkBlueMedium),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TripPassengerCompletedScreen extends StatelessWidget {
  const TripPassengerCompletedScreen({super.key});

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
                  context.pushNamedAndRemoveUntil(Routes.passengerHome);
                  context.read<PassengerHomeCubit>().emitAllTrip();
                },
                text: 'Go Home',
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
