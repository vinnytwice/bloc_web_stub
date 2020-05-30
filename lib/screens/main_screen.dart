import 'package:firebaseblocwebstub/screens/booking_screen.dart';
import 'package:firebaseblocwebstub/authentication_bloc/app_user.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final FixitUser user;

  const MainScreen({Key key, @required this.user})
      : assert(user != null),
        super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Widget> screens;

  @override
  void initState() {
    screens = [
      BookingScreen(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
//    Locale deviceLocale = Localizations.localeOf(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Bookings'),
          ),
//          new BottomNavigationBarItem(
//              icon: Icon(Icons.person), title: Text('Opening Times'))
        ],
      ),
      body: screens[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
