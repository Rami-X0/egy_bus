import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_result.dart';
import 'package:egy_bus/core/networking/api_services.dart';
import 'package:egy_bus/features/passenger_login/data/models/passenger_login_request.dart';
import 'package:egy_bus/features/passenger_login/data/models/passenger_login_response.dart';

class PassengerLoginRepo {
  final ApiServices _apiServices;

  PassengerLoginRepo(this._apiServices);

  Future<ApiResult<PassengerLoginResponse>> driverLogin(PassengerLoginRequest body) async {
    final response = await _apiServices.passengerLogin(body);
    try {
      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }
}
