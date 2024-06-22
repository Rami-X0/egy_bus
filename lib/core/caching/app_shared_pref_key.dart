import 'package:egy_bus/core/caching/app_shared_pref.dart';

class AppSharedPrefKey {
  static String driverUserId = 'driverUserId';
  static String passengerUserId = 'passengerUserId';
  static String onBoarding = 'onBoarding';
  static String driverIdFrom = 'driverFrom';
  static String driverIdTo = 'driverTo';
  static String passengerIdFrom = 'passengerFrom';
  static String passengerIdTo = 'passengerTo';
  static String passengerLong = 'passengerLong';
  static String passengerLat = 'passengerLat';
  static String stationLat = 'stationLat';
  static String stationLong = 'stationLong';
  static String passengerName = 'passengerName';
  static String driverLat = 'driverLat';
  static String driverLon = 'driverLon';
  static String driverStationLat = 'driverStationLat';
  static String driverStationLon = 'driverStationLon';
}

var driverUserId =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverUserId);
var onBoarding = AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.onBoarding);
var driverIdFrom =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverIdFrom);
var driverIdTo = AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverIdTo);
var passengerIdFrom =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerIdFrom);
var passengerIdTo =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerIdTo);

var passengerUserId =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerUserId);
var passengerLong =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerLong);
var passengerLat =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerLat);
var stationLong =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.stationLong);
var stationLat =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.stationLat);
var passengerName =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerName);
var driverLat =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverLat);
var driverLon =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverLon);
var driverStationLat =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverStationLat);
var driverStationLon =
    AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.driverStationLon);
