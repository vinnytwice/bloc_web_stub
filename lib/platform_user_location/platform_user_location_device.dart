import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:firebaseblocwebstub/platform_user_location/platform_user_location_switcher.dart';

class GeolocatorDevice implements UserLocation {
  Geolocator geolocator = Geolocator();
  @override
  Future<Map<String, dynamic>> getPosition() async {
    Position location;
    LatLng position = LatLng(0, 0);
    String isoPosition;
    try {
      location = await geolocator
          .getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              locationPermissionLevel: GeolocationPermission.locationWhenInUse)
          .timeout(Duration(seconds: 15));
      position = LatLng(double.parse(location.latitude.toStringAsFixed(4)),
          double.parse(location.longitude.toStringAsFixed(4)));
      print('GeolocatorDevice location is: $location');
      String isolat;
      String isoLon;
      if (position.latitude > 0) {
        isolat = '%2B${double.parse(position.latitude.toStringAsFixed(4))}';
      } else {
        isolat = '${double.parse(position.latitude.toStringAsFixed(4))}';
      }
      if (position.longitude > 0) {
        isoLon = '%2B${double.parse(position.longitude.toStringAsFixed(4))}';
      } else {
        isoLon = '${double.parse(position.longitude.toStringAsFixed(4))}';
      }
      isoPosition = isolat + isoLon;
      print('GeolocatorDevice isoPosition is $isoPosition');

      Map<String, dynamic> map = {
        'position': position,
        'isoPosition': isoPosition
      };

      return map;
    } catch (error) {
      print('Error fetching user position : $error');
    }
  }
}

UserLocation getUserLocation() => GeolocatorDevice();
