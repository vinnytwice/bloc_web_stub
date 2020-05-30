import 'package:firebaseblocwebstub/platform_user_location/user_location_stub.dart'
    if (dart.library.io) "package:firebaseblocwebstub/platform_user_location/platform_user_location_device.dart"
    if (dart.library.js) "package:firebaseblocwebstub/platform_user_location/platform_user_location_web.dart";

abstract class UserLocation {
  Future<Map<String, dynamic>> getPosition() async {
    Future<Map<String, dynamic>> position;
    return position;
  }

  factory UserLocation() => getUserLocation();
}
