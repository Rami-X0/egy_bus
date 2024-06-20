import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_result.dart';
import 'package:egy_bus/core/networking/api_services.dart';
import 'package:egy_bus/features/driver_home/data/models/add_trip_request.dart';
import 'package:egy_bus/features/driver_home/data/models/all_trip_response.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_add_station_request.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_station_link_response.dart';

class DriverHomeRepo {
  final ApiServices _apiServices;

  DriverHomeRepo(this._apiServices);

  Future<ApiResult<List<DriverStationLinkResponse>>> driverStationLink(
      String stationLink) async {
    try {
      final response = await _apiServices.driverStationLink(stationLink);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }

  Future<ApiResult> driverPostBusLine(
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

  Future<ApiResult> addTrip(AddTripeRequest body) async {
    try {
      final response = await _apiServices.addTripe(body);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }

  Future<ApiResult> deleteTrip(int id) async {
    try {
      final response = await _apiServices.deleteTrip(id);

      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }
}
