import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/di/dependency_injection.dart';
import 'package:egy_bus/core/helper/bloc_observer.dart';
import 'package:egy_bus/egy_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
 await AppSharedPref.initSharedPref();
  Bloc.observer = MyBlocObserver();

  driverUserId=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverUserId );
  onBoarding=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.onBoarding );
  driverIdTo=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverIdTo )??1;
  passengerIdFrom=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerIdFrom )??1;
  passengerIdTo=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerIdTo )??1;
  passengerUserId=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey. passengerUserId );
  passengerLong=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey. passengerLong );
  passengerLat=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey. passengerLat );
  stationLat=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey. stationLat );
  stationLong=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey. stationLong );
  passengerName=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey. passengerName );
  await ScreenUtil.ensureScreenSize();
  runApp(const EgyBus());
}

