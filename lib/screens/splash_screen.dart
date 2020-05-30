import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          backgroundColor: Colors.transparent,
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
//                    child: Image.asset('assets/flutter_logo.png', height: 200),
          child: Text(
            'Splash screen',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5),
          ),
        ),
      ),
    );
  }
}
