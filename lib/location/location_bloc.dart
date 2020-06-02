import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebaseblocwebstub/location/location_event.dart';
import 'package:firebaseblocwebstub/location/location_repository.dart';
import 'package:firebaseblocwebstub/location/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = LocationRepository();

  LocationState get initialState => UserLocation();

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
  }
}
