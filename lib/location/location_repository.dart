import 'dart:async';
import 'package:firebaseblocwebstub/platform_user_location/platform_user_location_switcher.dart';

class LocationRepository {
//  bool isTracking = false;
//  final locationManager = Geolocator();

//  Future<String> getIsoLocationUser() async {
////    print('getLocationISO6709() called');
//    Position position;
//    try {
//      position = await locationManager
//          .getCurrentPosition(
//              desiredAccuracy: LocationAccuracy.bestForNavigation)
//          .timeout(Duration(seconds: 15));
//      String isolat;
//      String isoLon;
//      if (position.latitude > 0) {
//        isolat = '%2B${double.parse(position.latitude.toStringAsFixed(4))}';
//      } else {
//        isolat = '${double.parse(position.latitude.toStringAsFixed(4))}';
//      }
//      if (position.longitude > 0) {
//        isoLon = '%2B${double.parse(position.longitude.toStringAsFixed(4))}';
//      } else {
//        isoLon = '${double.parse(position.longitude.toStringAsFixed(4))}';
//      }
//      String userLocationISO6709 = isolat + isoLon;
////      print('userLocationISO6709 is $userLocationISO6709');
//
//      return userLocationISO6709;
//    } catch (error) {
//      print(
//          'getLocation(): error getting current userLocationISO6709: ${error.toString()}');
//    }
//  }

//  Future<String> getIsoLocationDb() async {
//
//
////    print('getLocationISO6709() called');
//    Position position;
//    try {
//      position = await locationManager
//          .getCurrentPosition(
//              desiredAccuracy: LocationAccuracy.bestForNavigation,
//              locationPermissionLevel: GeolocationPermission.locationWhenInUse)
//          .timeout(Duration(seconds: 15));
//      String isolat;
//      String isoLon;
//      if (position.latitude > 0) {
//        isolat = '%2B${double.parse(position.latitude.toStringAsFixed(4))}';
//      } else {
//        isolat = '${double.parse(position.latitude.toStringAsFixed(4))}';
//      }
//      if (position.longitude > 0) {
//        isoLon = '%2B${double.parse(position.longitude.toStringAsFixed(4))}';
//      } else {
//        isoLon = '${double.parse(position.longitude.toStringAsFixed(4))}';
//      }
//      String userLocationISO6709 = isolat + isoLon;
//      print('getIsoLocationDb() userLocationISO6709 is $userLocationISO6709');
//
//      return userLocationISO6709;
//    } catch (error) {
//      print(
//          'getLocation(): error getting current userLocationISO6709: ${error.toString()}');
//    }
//  }

//  Future<Map<String, dynamic>> getLocation() async {
//    try {
//      UserLocation location = UserLocation();
//      var pos = await location.getPosition();
//      print('getLocation() pos is ${pos.toString()}');
//      Map<String, dynamic> locationDetails = {
//        'userLocation': pos['position'],
//        'userLocationIso': pos['isoPosition'],
//      };
//
//      return locationDetails;
//    } catch (error) {
//      print(
//          'getLocation(): error getting current location: ${error.toString()}');
//    }
//  }
  Future<Map<String, dynamic>> getLocation() async {
    try {
      UserLocation location = UserLocation();
      final pos = await location.getPosition();
      print('getLocation() pos is ${pos.toString()}');
      final locationDetails = {
        'userLocation': pos['position'],
        'userLocationIso': pos['isoPosition'],
      };
      return locationDetails;
    } catch (error) {
      print(
          'getLocation(): error getting current location: ${error.toString()}');
    }
  }
}
