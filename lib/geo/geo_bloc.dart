import 'geo_event.dart';
import 'geo_repository.dart';
import 'geo_state.dart';

import 'dart:async';
//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeoBloc extends Bloc<GeoEvent, GeoState> {
  GeoRepository _geoRepository = GeoRepository();
  @override
  GeoState get initialState => InitialState();

  @override
  Stream<GeoState> mapEventToState(GeoEvent event) async* {
    if (event is GetCityUser) {
      print(
          'GetCityUser event received coordinated ${event.userLocation.toString()}');
      yield* _mapGetCityUserToState(event);
    }

    if (event is CityUserReceived) {
      yield CityUser(event.city, event.region, event.country);
    }

    if (event is GetCityDb) {
      print(
          'GetCitydb event received coordinated ${event.userLocation.toString()}');
      yield* _mapGetCityDbToState(event);
    }

    if (event is CityDbReceived) {
      yield CityDb(event.city, event.region, event.country);
    }
  }

  Stream<GeoState> _mapGetCityUserToState(GetCityUser event) async* {
    await _geoRepository
        .getCityUser(event.userLocation)
        .then((List<String> cityUser) {
      add(CityUserReceived(cityUser[0], cityUser[1], cityUser[2]));
    });
  }

  Stream<GeoState> _mapGetCityDbToState(GetCityDb event) async* {
    await _geoRepository
        .getCityDb(event.userLocation)
        .then((List<String> cityDb) {
      add(CityDbReceived(cityDb[0], cityDb[1], cityDb[2]));
    });
  }
}
