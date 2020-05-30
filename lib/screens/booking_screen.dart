import 'dart:async';

import 'package:firebaseblocwebstub/authentication_bloc/app_user.dart';
import 'package:firebaseblocwebstub/authentication_bloc/authentication_bloc.dart';
import 'package:firebaseblocwebstub/authentication_bloc/authentication_event.dart';
import 'package:firebaseblocwebstub/geo/geo_bloc.dart';
import 'package:firebaseblocwebstub/geo/geo_event.dart';
import 'package:firebaseblocwebstub/geo/geo_state.dart';
import 'package:firebaseblocwebstub/localization.dart';
import 'package:firebaseblocwebstub/location/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong/latlong.dart';

class BookingScreen extends StatefulWidget {
  final FixitUser user;

  const BookingScreen({Key key, this.user}) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  FixitUser user;
  LatLng userLocation = LatLng(0, 0);
  String isoLocation;
  String cityUser;
  String regionUser;
  String countryUser;
  String cityDb;
  String regionDb;
  String countryDb;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          lazy: false,
          create: (context) => LocationBloc()..add(GetLocation()),
        ),
        BlocProvider<GeoBloc>(
          lazy: false,
          create: (context) => GeoBloc(),
        ),
      ],
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) => MultiBlocListener(
          listeners: [
            BlocListener<LocationBloc, LocationState>(
              listener: (BuildContext context, LocationState state) {
                if (state is UserLocation) {
                  setState(() {
                    userLocation = state.location;
                    print(
                        'Test 0 LocationBlocListener state.location is ${state.location.latitude},${state.location.longitude}');
                    // prints LocationBlocListener state.location is 0,0 ???

                    //Test 1 : Assign state value to variable and use it to send events
                    print('Test 1');
                    print(
                        'Test 1 LocationBlocListener state.location is ${state.location.latitude},${state.location.longitude}');
                    // GetCityUser gets called with state.location is 0,0 and fails..
                    BlocProvider.of<GeoBloc>(context)
                        .add(GetCityUser(userLocation));

                    BlocProvider.of<GeoBloc>(context)
                        .add(GetCityDb(userLocation));

                    // Test 2 : using state value directly
                    print('Test 2');
                    print(
                        'Test 2 LocationBlocListener state.location is ${state.location.latitude},${state.location.longitude}');
                    // GetCityUser gets called with state.location is 0,0 and fails..
                    BlocProvider.of<GeoBloc>(context)
                        .add(GetCityUser(state.location));

                    // GetCityDb gets called with correct state.location
                    BlocProvider.of<GeoBloc>(context)
                        .add(GetCityDb(state.location));

                    // Test 3 : Adding a Timer makes both events to be called with correct  coordinates.
                    print('Test 3');
                    print(
                        'Test 2 LocationBlocListener state.location is ${state.location.latitude},${state.location.longitude}');
                    Timer(Duration(milliseconds: 50), () {
                      print(
                          'LocationBlocListener sent GetCityUser and GetCityDb events with Timer..');
                      BlocProvider.of<GeoBloc>(context)
                          .add(GetCityUser(userLocation));
                      BlocProvider.of<GeoBloc>(context)
                          .add(GetCityDb(userLocation));
                    });
                  });
                }
              },
            ),
            BlocListener<GeoBloc, GeoState>(
                listener: (BuildContext context, GeoState state) {
              if (state is CityUser) {
                print('CityUser state');
                setState(() {
                  cityUser = (state).city;
                  regionUser = (state).region;
                  countryUser = (state).country;
                });
              }

              if (state is CityDb) {
                print('CityDb state');
                setState(() {
                  cityDb = (state).city;
                  regionDb = (state).region;
                  countryDb = (state).country;
                });
              }
            }),
          ],
          child: Scaffold(
            body: Container(
              color: Colors.black54,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        RaisedButton(
                            child: Text('logout ${widget.user.name}'),
                            onPressed: () {
                              print('logout pressed');
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(LoggedOut());
                            }),
                        SizedBox(width: 100),
                        Text(
                          widget.user.name,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        // user logo
                        Image(image: NetworkImage(widget.user.photoUrl))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        // time slots
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.redAccent, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'cityUser $cityUser',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'regionUser $regionUser',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'countryUser $countryUser',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'city db $cityDb',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'regionDb $regionDb',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'countryDb $countryDb',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'userlocation ${userLocation.latitude},${userLocation.longitude}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          flex: 5,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
