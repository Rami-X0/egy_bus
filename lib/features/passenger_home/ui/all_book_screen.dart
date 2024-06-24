import 'package:egy_bus/core/di/dependency_injection.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_loading.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBookScreen extends StatelessWidget {
  const AllBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PassengerHomeCubit>().emitPassengerAllBook();

    return BlocProvider.value(
      value: getIt<PassengerHomeCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Book'),
        ),
        body: BlocBuilder<PassengerHomeCubit, PassengerHomeState>(
          builder: (context, state) {

            return state.maybeWhen(
              orElse: () => Container(),
              passengerAllBookLoading: () {
                return const AppLoading();
              },
              passengerAllBookSuccess: (data) {
                return ListView.builder(

                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 190.h,
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey.withOpacity(0.5),
                        border: Border.all(color: Colors.grey, width: 1.5.w),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${data[index].passengerName.toString()}",
                              style: TextStyles.font11BlackMedium
                                  .copyWith(fontSize: 20.sp),
                            ),
                            Text(
                              "From Station: ${data[index].fromStation.toString()}",
                              style: TextStyles.font11BlackMedium
                                  .copyWith(fontSize: 20.sp),
                            ),
                            Text(
                              "To Station: ${data[index].toStationStation.toString()}",maxLines: 1,overflow: TextOverflow.ellipsis,
                              style: TextStyles.font11BlackMedium
                                  .copyWith(fontSize: 20.sp),
                            ),
                            Text(
                              'Amount Paid${data[index].amountPaid.toString()}',
                              style: TextStyles.font11BlackMedium
                                  .copyWith(fontSize: 20.sp),
                            ),
                            Text(
                              'Booking Date:${data[index].bookingDate.toString().substring(0, 10)}',
                              style: TextStyles.font11BlackMedium
                                  .copyWith(fontSize: 20.sp),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
