import 'dart:core';
import 'dart:async';
import 'package:firebaseblocwebstub/localization.dart';
import 'package:http/http.dart';
import 'package:latlong/latlong.dart';
import 'package:universal_html/prefer_universal/html.dart';
import 'dart:convert' as convert;

class GeoRepository {
  final String countryCode = AppLocalizations.instance.text('Country code');

//  Future<List<String>> getCityUser(String isoLocationUser) async {
  Future<List<String>> getCityUser(LatLng position) async {
//    print('getCityUser location is ${position.toString()}');
    String isoLocationUser;
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

    isoLocationUser = isolat + isoLon;

//    print('getCityUser called on $isoLocationUser');
//    print('getCityUser Country code is: $countryCode');

    final String request = countryCode == 'US'
        ? 'http://geodb-free-service.wirefreethought.com/v1/geo/cities?location=$isoLocationUser&radius=15&minPopulation=100000'
        : 'http://geodb-free-service.wirefreethought.com/v1/geo/cities?location=$isoLocationUser&radius=15&minPopulation=100000&languageCode=$countryCode';

    var response = await get(request, headers: {
      'x-rapidapi-host': 'http://geodb-free-service.wirefreethought.com',
    });
//    print('CityUser response is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<dynamic> properties = jsonResponse['data'];
      if (properties.length > 0) {
//        print('CityUser properties are $properties');
        String name = properties.first['name'].toString();
        String region = properties.first['region'].toString();
        String country = properties.first['country'].toString();

//        print(' getCityUser ${jsonResponse.runtimeType} : $jsonResponse');
//        print('getCityUser jsonResponse name is :$name');
//        print('getCityUser jsonResponse region is :$region');
//        print('getCityUser jsonResponse country is: $country');

        List<String> cityUser = new List<String>();
        cityUser.add(name);
        cityUser.add(region);
        cityUser.add(country);
        return cityUser;
      }
    } else {
      print(
          'getCityUser() Request failed with status: ${response.statusCode}.');
    }
  }

  Future<List<String>> getCityDb(LatLng position) async {
//    print('getCityDb location is ${position.toString()}');
    String isoLocationDb;
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

    isoLocationDb = isolat + isoLon;
//    print('getCityDb called on $isoLocationDb');
//    print('getCityDb Country code is: $countryCode');

    final String request =
        'http://geodb-free-service.wirefreethought.com/v1/geo/cities?location=$isoLocationDb&radius=15&minPopulation=100000';

    var response = await get(request, headers: {
      'x-rapidapi-host': 'http://geodb-free-service.wirefreethought.com',
    });
//    print('CityDb response is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<dynamic> properties = jsonResponse['data'];
      if (properties.length > 0) {
//        print('CityDb properties are $properties');
        String name = properties.first['name'].toString();
        String region = properties.first['region'].toString();
        String country = properties.first['country'].toString();

//        print(' getCityDb ${jsonResponse.runtimeType} : $jsonResponse');
//        print('getCityDb jsonResponse name is :$name');
//        print('getCityDb jsonResponse region is :$region');
//        print('getCityDb jsonResponse country is: $country');

        List<String> cityDb = new List<String>();
        cityDb.add(name);
        cityDb.add(region);
        cityDb.add(country);
        return cityDb;
      }
    } else {
      print('getCityDb() Request failed with status: ${response.statusCode}.');
    }
  }
}
