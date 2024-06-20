import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/features/driver_home/data/models/all_trip_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StationTripItem extends StatelessWidget {
  final AllTripResponse data;

  const StationTripItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(passengerName.toString()),
        centerTitle: true,
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
                    Text(
                      data.departureTime.substring(0, 10),
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        color: const Color(0xff666666),
                      ),
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
                                    '#1353274636',
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
                              data.fromStationName,
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
                              data.toStationName,
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
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Passenger No.',
                                style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '9',
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
                            '#7453478798523',
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
              Text(
                'Arrival Time',
                style: TextStyle(
                  fontSize: 18.0.w,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 4.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Color(0xff00ADCF),
                  ),
                  SizedBox(width: 4.0.w),
                  Text(
                    '00:05:00',
                    style: TextStyle(
                      color: const Color(0xff00ADCF),
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300.w, 60.h),
                  backgroundColor: const Color(0xff00ADCF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0.r),
                  ),
                ),
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                label: const Text(
                  'Download Ticket',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0.h),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300.w, 60.h),
                  backgroundColor: const Color(0xff00ADCF),
                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: const Icon(Icons.location_on_sharp, color: Colors.white),
                label: const Text(
                  'Show Direction',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0.h),
              OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(300.w, 60.h),
                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                  side: const BorderSide(
                    color: Color(0xff00ADCF),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Go To Home',
                  style: TextStyle(
                    color: Color(0xff00ADCF),
                  ),
                ),
              ),
              SizedBox(height: 16.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
