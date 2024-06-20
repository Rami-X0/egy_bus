import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_result.dart';
import 'package:egy_bus/core/networking/api_services.dart';
import 'package:egy_bus/features/driver_sign_up/data/models/driver_sign_up_request.dart';

class DriverSignUpRepo {
  final ApiServices _apiServices;

  DriverSignUpRepo(this._apiServices);

  Future<ApiResult> driverSignUp(DriverSignUpRequest body) async {
    final response = await _apiServices.driverSignUp(body);

    try {
      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }
}
