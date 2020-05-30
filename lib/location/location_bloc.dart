import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebaseblocwebstub/location/location_event.dart';
import 'package:firebaseblocwebstub/location/location_repository.dart';
import 'package:firebaseblocwebstub/location/location_state.dart';
import 'package:latlong/latlong.dart';
//import 'location_event.dart';
//import 'location_repository.dart';
//import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = LocationRepository();
  LatLng location;
  LatLng locationStream;

  LocationState get initialState => UserLocation(locationStream);

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is GetLocation) {
      yield* _mapGetLocationToState(event);
    }
  }

  Stream<LocationState> _mapGetLocationToState(GetLocation event) async* {
    Map<String, dynamic> userLocationMap =
        await _locationRepository.getLocation();
    yield UserLocation(userLocationMap['userLocation']);
//    yield IsoLocationUser(userLocationMap['userLocationIso']);
//    yield IsoLocationDb(userLocationMap['userLocationIso']);
  }
}
