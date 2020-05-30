import 'package:firebaseblocwebstub/authentication_bloc/bloc.dart';
import 'package:firebaseblocwebstub/authentication_bloc/user_repository.dart';
import 'package:firebaseblocwebstub/login/bloc/login_bloc.dart';
import 'package:firebaseblocwebstub/login/bloc/login_event.dart';
import 'package:firebaseblocwebstub/login/bloc/login_state.dart';
import 'package:firebaseblocwebstub/login/google_login_button.dart';
import 'package:firebaseblocwebstub/login/login_button.dart';
import 'package:firebaseblocwebstub/register/create_account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
//  final _userRepository; // class with signin methods platform dependent

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    double padding;
    double verticalPadding;
    if (MediaQuery.of(context).size.width > 1000) {
      padding = 380;
      verticalPadding = 120;
    } else if (MediaQuery.of(context).size.width > 400 &&
        MediaQuery.of(context).size.width < 1000) {
      padding = 250;
      verticalPadding = 250;
    } else {
      padding = 20;
      verticalPadding = 100;
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          print('LoginForm login BlocListener state received is : isSuccess ');
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
//                    child: Image.asset('assets/flutter_logo.png', height: 200),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
//                    cursorWidth: 30,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    cursorColor: Colors.white,
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email, color: Colors.white),
                      labelText: 'Email',
//                      fillColor: Colors.grey.shade400,
//                      filled: true,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    cursorColor: Colors.white,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    obscureText: true,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
//                  Padding(
//                    padding: EdgeInsets.symmetric(vertical: 20),
//                    child: Column(
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      LoginButton(
                        onPressed: isLoginButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                      ),
                      GoogleLoginButton(),
                      CreateAccountButton(userRepository: _userRepository),
                    ],
                  ),
//                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
