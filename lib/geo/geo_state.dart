import 'dart:core';

abstract class GeoState {
  GeoState();
  List<Object> get props => [];
}

class InitialState extends GeoState {}

class CityUser extends GeoState {
  final String city;
  final String region;
  final String country;
  CityUser(this.city, this.region, this.country);

  List<Object> get props => [city, region, country];

  @override
  String toString() =>
      'CityUser {city: $city, region: $region, country: $country}';
}

class CityDb extends GeoState {
  final String city;
  final String region;
  final String country;
  CityDb(this.city, this.region, this.country);

  List<Object> get props => [city, region, country];
}
