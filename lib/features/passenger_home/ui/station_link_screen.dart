import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/features/passenger_home/data/repo/bus_line_response.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioList extends StatefulWidget {
  final List<BusLineResponse> data;
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
