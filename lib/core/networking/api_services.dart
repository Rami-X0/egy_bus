import 'package:dio/dio.dart';
import 'package:egy_bus/core/networking/api_constants.dart';
import 'package:egy_bus/features/driver_home/data/models/add_trip_request.dart';
import 'package:egy_bus/features/driver_home/data/models/all_trip_response.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_add_station_request.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_station_link_response.dart';
import 'package:egy_bus/features/driver_login/data/models/driver_login_request.dart';
import 'package:egy_bus/features/driver_login/data/models/driver_login_response.dart';
import 'package:egy_bus/features/driver_sign_up/data/models/driver_sign_up_request.dart';
import 'package:egy_bus/features/passenger_home/data/repo/add_book_model.dart';
import 'package:egy_bus/features/passenger_home/data/repo/bus_line_response.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_profile_reponse.dart';
import 'package:egy_bus/features/passenger_login/data/models/passenger_login_request.dart';
import 'package:egy_bus/features/passenger_login/data/models/passenger_login_response.dart';
import 'package:egy_bus/features/passenger_sign_up/data/models/passenger_sign_up_request.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @POST(ApiConstants.driverSignUp)
  Future driverSignUp(@Body() DriverSignUpRequest body);

  @POST(ApiConstants.driverLogin)
  Future<DriverLoginResponse> driverLogin(@Body() DriverLoginRequest body);

  @GET("${ApiConstants.driverStationLink}/{LineCode}")
  Future<List<DriverStationLinkResponse>> driverStationLink(
      @Path('LineCode') String linkCode);

  @POST(ApiConstants.driverBusLine)
  Future<DriverLoginResponse> driverPostBusLine(
      @Body() DriverAddBusLineRequest body);

  @GET("${ApiConstants.allTrip}/{FromStationId}/{ToStationId}")
  Future<List<AllTripResponse>> allTrip(
      @Path('FromStationId') int fromStationId,
      @Path('ToStationId') int toStationId);

  @POST(ApiConstants.addTrip)
  Future addTripe(@Body() AddTripeRequest body);

  @POST(ApiConstants.passengerLogin)
  Future<PassengerLoginResponse> passengerLogin(
      @Body() PassengerLoginRequest body);

  @POST(ApiConstants.passengerSignUp)
  Future passengerSignUp(@Body() PassengerSignUpRequest body);

  @POST(ApiConstants.passengerAddBookZone)
  Future passengerAddBook(@Body() AddBookModel body);

  @GET('${ApiConstants.passengerProfileData}/{id}')
  Future<PassengerProfileResponse> passengerProfileData(@Path('id') int id);

  @GET(ApiConstants.passengerStation)
  Future<List<BusLineResponse>> passengerStation();

  @DELETE('${ApiConstants.deleteTrip}/{id}')
  Future deleteTrip(@Path('id') int id);
}
