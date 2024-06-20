import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_result.dart';
import 'package:egy_bus/core/networking/api_services.dart';
import 'package:egy_bus/features/driver_login/data/models/driver_login_request.dart';
import 'package:egy_bus/features/driver_login/data/models/driver_login_response.dart';

class DriverLoginRepo {
  final ApiServices _apiServices;

  DriverLoginRepo(this._apiServices);

  Future<ApiResult<DriverLoginResponse>> driverLogin(DriverLoginRequest body) async {
    final response = await _apiServices.driverLogin(body);
    try {
      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }
}
