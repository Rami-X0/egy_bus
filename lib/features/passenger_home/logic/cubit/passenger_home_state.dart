import 'package:dio/dio.dart';
import 'package:egy_bus/features/driver_home/data/models/all_trip_response.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_station_link_response.dart';
import 'package:egy_bus/features/passenger_home/data/repo/all_book_response.dart';
import 'package:egy_bus/features/passenger_home/data/repo/bus_line_response.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_book_trip_response.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_profile_reponse.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "passenger_home_state.freezed.dart";

@freezed
class PassengerHomeState with _$PassengerHomeState {
  const factory PassengerHomeState.initial() = _Initial;

  const factory PassengerHomeState.getStationPassengerLineLoading() =
      GetStationPassengerLineLoading;

  const factory PassengerHomeState.getStationLineSuccess(
      {required List<DriverStationLinkResponse>
          driverStationLinkResponse}) = GetStationLineSuccess;

  const factory PassengerHomeState.getStationLineLoading() =
      GetStationLineLoading;

  const factory PassengerHomeState.getBusLineSuccess(
          {required List<BusLineResponse> driverStationLinkResponse}) =
      GetBusLineSuccess;

  const factory PassengerHomeState.getStationLineFailure(
      {required DioException apiError}) = GetStationLineFailure;

  const factory PassengerHomeState.postBusLineLoading() = PostBusLineLoading;

  const factory PassengerHomeState.postBusLineSuccess() = PostBusLineSuccess;

  const factory PassengerHomeState.postBusLineFailure(
      {required DioException apiError}) = PostBusLineFailure;

  const factory PassengerHomeState.allTripsLoading() = AllTripsLoading;

  const factory PassengerHomeState.allTripsSuccess(
      {required List<AllTripResponse> allTripsResponseList}) = AllTripsSuccess;

  const factory PassengerHomeState.allTripsFailure(
      {required DioException apiError}) = AllTripsFailure;

  const factory PassengerHomeState.addTripsLoading() = AddTripsLoading;

  const factory PassengerHomeState.addTripsSuccess() = AddTripsSuccess;

  const factory PassengerHomeState.addTripsFailure(
      {required DioException apiError}) = AddTripsFailure;

  const factory PassengerHomeState.addBookLoading() = AddBookLoading;

  const factory PassengerHomeState.addBookSuccess() = AddBookSuccess;

  const factory PassengerHomeState.addBookFailure(
      {required DioException apiError}) = AddBookFailure;

  const factory PassengerHomeState.passengerProfileLoading() =
      PassengerProfileLoading;

  const factory PassengerHomeState.passengerPaymentLoading() =
      PassengerPaymentLoading;

  const factory PassengerHomeState.passengerPaymentSuccess() =
      PassengerPaymentSuccess;

  const factory PassengerHomeState.passengerPaymentFailure(
      {required DioException apiError}) = PassengerPaymentFailure;

  const factory PassengerHomeState.passengerProfileSuccess(
      {required PassengerProfileResponse data}) = PassengerProfileSuccess;

  const factory PassengerHomeState.passengerProfileFailure(
      {required DioException apiError}) = PassengerProfileFailure;

  const factory PassengerHomeState.passengerGoingToHome() =
      PassengerGoingToHome;

  const factory PassengerHomeState.passengerBooKTripSuccess(
      {required PassengerBookTripResponse response}) = PassengerBooKTripSuccess;

  const factory PassengerHomeState.passengerBooKTripLoading(
      {required int index}) = PassengerBooKTripLoading;

  const factory PassengerHomeState.passengerBooKTripFailure({
    required DioException failure,
  }) = PassengerBooKTripFailure;

  const factory PassengerHomeState.passengerAllBookLoading() =
  PassengerAllBookLoading;

  const factory PassengerHomeState.passengerAllBookSuccess(
  {required List<PassengerBookResponse> data}
      ) =
  PassengerAllBookSuccess;

  const factory PassengerHomeState.passengerAllBookFailure(
      {required DioException apiError}) = PassengerAllBookFailure;


}
