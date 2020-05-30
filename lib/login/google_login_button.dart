import 'package:firebaseblocwebstub/login/bloc/login_bloc.dart';
import 'package:firebaseblocwebstub/login/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
      icon: Image.asset(
        'assets/googleLogo.png',
        scale: 1,
        width: 25,
        height: 25,
      ),

//        color: Colors.white,
//      )
      label: Text(
        'Google sign in',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      color: Colors.white,
    );
  }
}
