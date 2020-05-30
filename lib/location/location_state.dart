import 'dart:core';

import 'package:latlong/latlong.dart';

abstract class LocationState {
  const LocationState();

  List<Object> get props => [];
}

class UserLocation extends LocationState {
  final LatLng location;

  const UserLocation(this.location);

  @override
  List<Object> get props => [location];

  @override
  String toString() => 'UserLocation {location: $location}';
}

class IsoLocationUser extends LocationState {
  final String isoLocationUser;

  const IsoLocationUser(this.isoLocationUser);

  @override
  List<Object> get props => [isoLocationUser];

  @override
  String toString() => 'GetIsoLocationUser {isoLocation: $isoLocationUser}';
}

class IsoLocationDb extends LocationState {
  final String isoLocationDb;

  const IsoLocationDb(this.isoLocationDb);

  @override
  List<Object> get props => [isoLocationDb];

  @override
  String toString() => 'GetIsoLocationDb {ioLocation: $isoLocationDb}';
}
