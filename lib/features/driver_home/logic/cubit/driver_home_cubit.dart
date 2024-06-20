import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/features/driver_home/data/models/add_trip_request.dart';
import 'package:egy_bus/features/driver_home/data/models/driver_add_station_request.dart';
import 'package:egy_bus/features/driver_home/data/repo/driver_login_repo.dart';
import 'package:egy_bus/features/driver_home/logic/cubit/driver_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  final DriverHomeRepo _driverHomeRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController stationLinkController = TextEditingController();
  final TextEditingController availableSeatsTripController =
      TextEditingController();
  final TextEditingController priceTripController = TextEditingController();
  final TextEditingController busPlateController = TextEditingController();

  int? stationIdFrom;
  int? stationIdTo;

  DriverHomeCubit(this._driverHomeRepo)
      : super(const DriverHomeState.initial());

  Future<void> emitDriverStationLink() async {
    emit(const DriverHomeState.getStationLineLoading());

    final response =
        await _driverHomeRepo.driverStationLink(stationLinkController.text);

    response.when(success: (data) {
      emit(DriverHomeState.getStationLineSuccess(
          driverStationLinkResponse: data));
    }, failure: (failure) {
      emit(DriverHomeState.getStationLineFailure(apiError: failure));
    });
  }

  Future<void> emitDriverPostBusLine() async {
    emit(const DriverHomeState.postBusLineLoading());

    final response =
        await _driverHomeRepo.driverPostBusLine(DriverAddBusLineRequest(
      lineCode: stationLinkController.text,
      stationIdFrom: stationIdFrom!,
      stationIdTo: stationIdTo!,
    ));

    response.when(success: (data) {
      emit(const DriverHomeState.postBusLineSuccess());
    }, failure: (failure) {
      emit(DriverHomeState.postBusLineFailure(apiError: failure));
    });
  }

  Future<void> emitAllTrip() async {
    emit(const DriverHomeState.allTripsLoading());
    driverIdFrom = await AppSharedPref.sharedPrefGet(
          key: AppSharedPrefKey.driverIdFrom,
        ) ??
        1;

    driverIdTo = await AppSharedPref.sharedPrefGet(
          key: AppSharedPrefKey.driverIdTo,
        ) ??
        1;
    final int driverFrom = driverIdFrom;
    final int driverTo = driverIdTo;
    final response = await _driverHomeRepo.allTrip(driverFrom, driverTo);

    response.when(success: (data) {
      emit(DriverHomeState.allTripsSuccess(allTripsResponseList: data));
    }, failure: (failure) {
      emit(DriverHomeState.allTripsFailure(apiError: failure));
    });
  }

  Future<void> emitAddTrip() async {
    emit(const DriverHomeState.addTripsLoading());
    final int availableSeats = int.parse(availableSeatsTripController.text);
    final int price = int.parse(priceTripController.text);
    final int driverFrom = driverIdFrom ?? stationIdFrom;
    final int driverTo = driverIdTo ?? stationIdTo;

    final response = await _driverHomeRepo.addTrip(
      AddTripeRequest(
        fromStationId: driverFrom,
        toStationId: driverTo,
        departureTime: DateTime.now().toUtc().toIso8601String().toString(),
        availableSeats: availableSeats,
        price: price,
        driverId: driverUserId,
        busPlate: busPlateController.text,
      ),
    );

    response.when(success: (data) {
      emit(const DriverHomeState.addTripsSuccess());
    }, failure: (failure) {
      emit(DriverHomeState.addTripsFailure(apiError: failure));
    });
  }

  Future<void> emitDeleteTrip(int id) async {
    emit(const DriverHomeState.deleteTripsLoading());

    final response = await _driverHomeRepo.deleteTrip(id);

    response.when(success: (data) {
      emit(const DriverHomeState.deleteTripsSuccess());
    emitAllTrip();
      }, failure: (failure) {
      emit(DriverHomeState.deleteTripsFailure(apiError: failure));
    });
  }
}
