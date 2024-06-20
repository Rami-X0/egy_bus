class ApiConstants {
  // base url for api
  static const String baseUrl = "http://busstation.somee.com";

  // base url for driver account
  static const String driverSignUp = "/api/Auth/DriverRegister";
  static const String driverLogin = "/api/Auth/DriverLogin";
  // base url driver home
  static const String driverStationLink = "/api/Station/GetStationsByBusLineCode";
  static const String driverBusLine = "/api/BusLine";
  static const String allTrip = "/api/Trip/GetTripFromStationToStation";
  static const String addTrip = "/api/Trip";
  static const String deleteTrip = "/api/Trip";
// base url for passenger account
  static const String passengerLogin = "/api/Auth/PassengerLogin";
  static const String passengerSignUp = "/api/Auth/PassengerRegister";
  static const String passengerAddBookZone = "/api/Booking/CanBookInZone";
  static const String passengerProfileData = "/api/Passenger";
  static const String passengerStation = "/api/Station";

}
