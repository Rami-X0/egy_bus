import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_result.dart';
import 'package:egy_bus/core/networking/api_services.dart';
import 'package:egy_bus/features/driver_home/data/models/all_trip_response.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_add_station_request.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_station_link_response.dart';
import 'package:egy_bus/features/passenger_home/data/repo/add_book_model.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_profile_reponse.dart';

class PassengerHomeRepo {
  final ApiServices _apiServices;

  PassengerHomeRepo(this._apiServices);

  Future<ApiResult<List<DriverStationLinkResponse>>> passengerStationLink(
      String stationLink) async {
    try {
      final response = await _apiServices.driverStationLink(stationLink);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }

  Future<ApiResult> passengerPostBusLine(
      DriverAddBusLineRequest postBusLine) async {
    try {
      final response = await _apiServices.driverPostBusLine(postBusLine);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }

  Future<ApiResult<List<AllTripResponse>>> allTrip(
      int fromStationId, int toStationId) async {
    try {
      final response = await _apiServices.allTrip(fromStationId, toStationId);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }

  Future<ApiResult> addBook(AddBookModel body) async {
    // debugPrint('repoooonse${body.passengerLat}');
    // debugPrint('repoooonse${body.passengerLon}');
    // debugPrint('repoooonse${body.stationLon}');
    // debugPrint('repoooonse${body.stationLat}');
    try {
      final response = await _apiServices.passengerAddBook(body);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }

  Future<ApiResult<PassengerProfileResponse>> passengerProfile(int id) async {
    try {
      final response = await _apiServices.passengerProfileData(id);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }
}
