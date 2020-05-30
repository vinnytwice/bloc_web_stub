import 'dart:io';
import 'package:firebaseblocwebstub/authentication_bloc/user_repository.dart';
import 'package:firebaseblocwebstub/register/bloc/bloc.dart';
import 'package:firebaseblocwebstub/register/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;
//  final _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic backButton;
    if (kIsWeb) {
      backButton = Icons.arrow_back;
    } else if (Platform.isIOS) {
      backButton = CupertinoIcons.back;
    } else {
      backButton = Icons.arrow_back;
    }
    return Stack(
      children: [
        Image.asset('assets/mainBg.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Register',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
                icon: Icon(backButton),
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(userRepository: _userRepository),
            child: RegisterForm(),
          ),
        ),
      ],
    );
  }
}
