import 'package:dio/dio.dart';
import 'package:egy_bus/features/driver_home/data/models/all_trip_response.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_station_link_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "driver_home_state.freezed.dart";

@freezed
class DriverHomeState with _$DriverHomeState {
  const factory DriverHomeState.initial() = _Initial;

  const factory DriverHomeState.getStationLineLoading() = GetStationLineLoading;

  const factory DriverHomeState.getStationLineSuccess(
      {required List<DriverStationLinkResponse>
          driverStationLinkResponse}) = GetStationLineSuccess;

  const factory DriverHomeState.getStationLineFailure(
      {required DioException apiError}) = GetStationLineFailure;

  const factory DriverHomeState.postBusLineLoading() = PostBusLineLoading;

  const factory DriverHomeState.postBusLineSuccess() = PostBusLineSuccess;

  const factory DriverHomeState.postBusLineFailure(
      {required DioException apiError}) = PostBusLineFailure;

  const factory DriverHomeState.allTripsLoading() = AllTripsLoading;

  const factory DriverHomeState.allTripsSuccess(
      {required List<AllTripResponse> allTripsResponseList}) = AllTripsSuccess;

  const factory DriverHomeState.allTripsFailure(
      {required DioException apiError}) = AllTripsFailure;

  const factory DriverHomeState.addTripsLoading() = AddTripsLoading;

  const factory DriverHomeState.addTripsSuccess() = AddTripsSuccess;

  const factory DriverHomeState.addTripsFailure(
      {required DioException apiError}) = AddTripsFailure;
}
