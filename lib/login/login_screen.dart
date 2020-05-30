import 'package:firebaseblocwebstub/authentication_bloc/user_repository.dart';
import 'package:firebaseblocwebstub/login/bloc/login_bloc.dart';
import 'package:firebaseblocwebstub/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
//      Image.asset('assets/mainBg.png',
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          fit: BoxFit.cover),
      Scaffold(
        backgroundColor: Colors.transparent,
//      backgroundColor: Colors.black26,
//      appBar: AppBar(
//        title: Text(
//          'Login',
//          style: TextStyle(color: Colors.orangeAccent, fontSize: 30),
//        ),
//        elevation: 0,
//        backgroundColor: Colors.transparent,
//      ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: LoginForm(userRepository: _userRepository),
        ),
      ),
    ]);
  }
}
