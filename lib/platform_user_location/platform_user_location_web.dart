import 'package:firebaseblocwebstub/platform_user_location/web_location.dart';
import 'package:firebaseblocwebstub/platform_user_location/platform_user_location_switcher.dart';
import 'package:js/js.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';

class GeolocatorWeb implements UserLocation {
  @override
  Future<Map<String, dynamic>> getPosition() async {
    LatLng position = LatLng(0, 0);
    String isoPosition;
    final completer = Completer<Map<String, dynamic>>();
    getCurrentPosition(allowInterop((pos) {
      try {
        position.longitude = pos.coords.longitude;
        position.latitude = pos.coords.latitude;
        completer.complete({'position': position, 'isoPosition': isoPosition});
      } catch (error) {
        completer.completeError(error);
        print('Error is : $error');
      }
    }));

    return completer.future;
  }
}

UserLocation getUserLocation() => GeolocatorWeb();
