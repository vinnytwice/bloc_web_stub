import 'package:latlong/latlong.dart';

abstract class GeoEvent {
  const GeoEvent();
  List<Object> get props => [];
}

//class GetCityUser extends GeoEvent {
//  final String isoLocation;
//  GetCityUser(this.isoLocation);
//  List<Object> get props => [isoLocation];
//  @override
//  String toString() => 'GetCityUser {isoLocation is : $isoLocation}';
//}

class GetCityUser extends GeoEvent {
  final LatLng userLocation;
  GetCityUser(this.userLocation);
  List<Object> get props => [userLocation];
  @override
  String toString() => 'GetCityUser {isoLocation is : $userLocation}';
}

class CityUserReceived extends GeoEvent {
  final String city;
  final String region;
  final String country;
  CityUserReceived(this.city, this.region, this.country);

  List<Object> get props => [city, region, country];

  @override
  String toString() =>
      'CityUserReceived {city: $city, region: $region, country: $country}';
}

//class GetCityDb extends GeoEvent {
//  final String isoLocation;
//  GetCityDb(this.isoLocation);
//
//  List<Object> get props => [isoLocation];
//
//  @override
//  String toString() => 'GetCityDb {isoLocation: $isoLocation}';
//}

class GetCityDb extends GeoEvent {
  final LatLng userLocation;
  GetCityDb(this.userLocation);

  List<Object> get props => [userLocation];

  @override
  String toString() => 'GetCityDb {isoLocation: $userLocation}';
}

class CityDbReceived extends GeoEvent {
  final String city;
  final String region;
  final String country;

  CityDbReceived(this.city, this.region, this.country);

  List<Object> get props => [city, region, country];

  @override
  String toString() =>
      'CityDbReceived {city: $city, region: $region, country: $country}';
}
