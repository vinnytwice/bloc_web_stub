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
    await getCurrentPosition(allowInterop((pos) {
      try {
        position.longitude = pos.coords.longitude;
        position.latitude = pos.coords.latitude;
      } catch (error) {
        print('Error is : $error');
      }
      return;
    }));

    Map<String, dynamic> map = {
      'position': position,
      'isoPosition': isoPosition
    };

    return map;
  }
}

UserLocation getUserLocation() => GeolocatorWeb();
