import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/widgets/app_snack_bar.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_add_station_request.dart';
import 'package:egy_bus/features/passenger_home/data/repo/add_book_model.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_book_trip_request.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_login_repo.dart';
import 'package:egy_bus/features/passenger_home/data/repo/passenger_payment_response.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class PassengerHomeCubit extends Cubit<PassengerHomeState> {
  final PassengerHomeRepo _passengerHomeRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController stationLinkController = TextEditingController();
  final TextEditingController availableSeatsTripController =
      TextEditingController();
  final TextEditingController priceTripController = TextEditingController();
  final TextEditingController busPlateController = TextEditingController();
  bool? serviceEnabled;
  LocationPermission? permission;
  int? stationIdFrom;
  int? stationIdTo;
  double? stationLon;
  double? stationLa;
  double? positionLat;
  double? positionLong;
  int counter = 1;
  double? totalValue;
  int? bookingId;

  PassengerHomeCubit(this._passengerHomeRepo)
      : super(const PassengerHomeState.initial());

  Future<void> emitPassengerStationLink() async {
    emit(const PassengerHomeState.getStationPassengerLineLoading());

    final response = await _passengerHomeRepo
        .passengerStationLink(stationLinkController.text);

    response.when(success: (data) {
      emit(PassengerHomeState.getStationLineSuccess(
          driverStationLinkResponse: data));
    }, failure: (failure) {
      emit(PassengerHomeState.getStationLineFailure(apiError: failure));
    });
  }

  Future<void> emitPassengerPostBusLine() async {
    emit(const PassengerHomeState.postBusLineLoading());

    final response =
        await _passengerHomeRepo.passengerPostBusLine(DriverAddBusLineRequest(
      lineCode: stationLinkController.text,
      stationIdFrom: stationIdFrom!,
      stationIdTo: stationIdTo!,
    ));

    response.when(success: (data) {
      emit(const PassengerHomeState.postBusLineSuccess());
    }, failure: (failure) {
      emit(PassengerHomeState.postBusLineFailure(apiError: failure));
    });
  }

  Future<void> emitAllTrip() async {
    emit(const PassengerHomeState.allTripsLoading());
    passengerIdTo = await AppSharedPref.sharedPrefGet(
          key: AppSharedPrefKey.passengerIdTo,
        ) ??
        1;
    passengerUserId = await AppSharedPref.sharedPrefGet(
          key: AppSharedPrefKey.passengerUserId,
        ) ??
        1;
    final int passengerFrom = passengerIdFrom ?? 1;
    final int passengerTo = passengerIdTo ?? 1;
    final response =
        await _passengerHomeRepo.allTrip(passengerFrom, passengerTo);

    response.when(success: (data) {
      emit(PassengerHomeState.allTripsSuccess(allTripsResponseList: data));
    }, failure: (failure) {
      emit(PassengerHomeState.allTripsFailure(apiError: failure));
    });
  }

  Future<void> emitAddBook(int index, BuildContext context) async {
    emit(PassengerHomeState.addBookLoading(index: index));
    await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerLong);
    await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerLat);
    final response = await _passengerHomeRepo.addBook(
      AddBookModel(
        passengerLat: passengerLat ?? positionLat,
        passengerLon: passengerLong ?? positionLong,
        stationLat: stationLat ?? stationLa,
        stationLon: stationLong ?? stationLon,
      ),
    );

    response.when(success: (data) {
      emit(const PassengerHomeState.addBookSuccess());
      context.pushNamedAndRemoveUntil(Routes.passengerHome);
    }, failure: (failure) {
      context.pop();
      appSnackBar(
          text: 'You can,\ t book this trip',
          backGroundColor: Colors.red,
          context: context);
      emit(PassengerHomeState.addBookFailure(apiError: failure));
    });
  }

  Future<void> emitPassengerProfileResponse() async {
    emit(const PassengerHomeState.passengerProfileLoading());

    final response = await _passengerHomeRepo.passengerProfile(passengerUserId);

    response.when(success: (data) {
      emit(PassengerHomeState.passengerProfileSuccess(data: data));
    }, failure: (failure) {
      emit(PassengerHomeState.passengerProfileFailure(apiError: failure));
    });
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      Navigator.of(context).pop();
      appSnackBar(
        text: 'Please open location ',
        backGroundColor: Colors.grey,
        context: context,
      );
    }
  }

  Future<void> getPermissionLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      getCurrentLocation(context);
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      positionLong = position.longitude;
      positionLat = position.latitude;
      await AppSharedPref.sharedPrefSet(
          key: AppSharedPrefKey.passengerLong, value: position.longitude);
      await AppSharedPref.sharedPrefSet(
          key: AppSharedPrefKey.passengerLat, value: position.latitude);
      emit(const PassengerHomeState.postBusLineLoading());
      debugPrint('passenget${positionLat}');
      debugPrint('passenget${positionLong}');
    }
    await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerLong);
    await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.passengerLat);
  }

  Future<void> emitBusLineResponse() async {
    emit(const PassengerHomeState.getStationLineLoading());

    final response = await _passengerHomeRepo.passengerBusLine();

    response.when(
        success: (data) {
          emit(PassengerHomeState.getBusLineSuccess(
              driverStationLinkResponse: data));
        },
        failure: (failure) {});
  }

  Future<void> emitPassengerPayment() async {
    emit(const PassengerHomeState.passengerPaymentLoading());

    final response = await _passengerHomeRepo.passengerPayment(
      PassengerPaymentRequest(
        bookingId: bookingId!,
        amount: totalValue!.toInt(),
        paymentDate: DateTime.now().toIso8601String().toString(),
        paymentTypeId: 2,
      ),
    );

    response.when(success: (data) {
      emit(const PassengerHomeState.passengerPaymentSuccess());
    }, failure: (failure) {
      emit(PassengerHomeState.passengerPaymentFailure(apiError: failure));
    });
  }

  Future<void> emitPassengerBookTrip(
      int tripId, int index, BuildContext context) async {
    emit(PassengerHomeState.passengerBooKTripLoading(index: index));

    final response = await _passengerHomeRepo.passengerBookTrip(
      PassengerBookTripRequest(
        passengerId: passengerUserId,
        tripId: tripId,
        seatsBooked: 1,
        amountPaid: 15,
      ),
    );

    response.when(success: (data) {
      bookingId = data.bookingId;
      emit(PassengerHomeState.passengerBooKTripSuccess(response: data));
      appSnackBar(
          text: data.message, backGroundColor: Colors.green, context: context);
    }, failure: (failure) {
      emit(PassengerHomeState.passengerBooKTripFailure(failure: failure));
      appSnackBar(
          text: 'can\'t book this trip',
          backGroundColor: Colors.red,
          context: context);
    });
  }
}
