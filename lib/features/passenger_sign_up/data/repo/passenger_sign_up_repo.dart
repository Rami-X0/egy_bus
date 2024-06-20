import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_result.dart';
import 'package:egy_bus/core/networking/api_services.dart';
import 'package:egy_bus/features/passenger_sign_up/data/models/passenger_sign_up_request.dart';

class PassengerSignUpRepo {
  final ApiServices _apiServices;

  PassengerSignUpRepo(this._apiServices);

  Future<ApiResult> passengerSignUp(PassengerSignUpRequest body) async {
    final response = await _apiServices.passengerSignUp(body);

    try {
      return ApiResult.success(response);
    } on DioException catch (failure) {
      return ApiResult.failure(failure);
    }
  }
}
