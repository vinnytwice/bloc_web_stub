import 'dart:async';
import 'package:firebaseblocwebstub/authentication_bloc/user_repository.dart';
import 'package:firebaseblocwebstub/login/bloc/login_event.dart';
import 'package:firebaseblocwebstub/login/bloc/login_state.dart';
import 'package:firebaseblocwebstub/login/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

//import 'package:fixit_cloud_biking/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository; // class with signin methods
//  var _userRepository; // class with signin methods platform dependent

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent loginEvent) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      print('login with google press event received');
      yield* _mapLoginWithGooglePressed();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressed(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(
          email), //Validators.isValidEmail returns param named email
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(
          password), //Validators.isValidPassword returns param named password
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressed() async* {
    try {
      await _userRepository.signInWithGoogle();
      print('Google signin success');
      yield LoginState.success();
    } catch (err) {
      print('Google signin error: $err');
      print('login with Google failure');
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressed({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    await _userRepository.signInWithCredential(
        email: email, password: password);
    try {} catch (_) {
      yield LoginState.failure();
    }
  }
}
