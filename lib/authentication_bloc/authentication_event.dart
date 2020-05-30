import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartApp extends AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {
  //TODO: check saved app state and
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  //TODO: save app state
}

class LoggedOut extends AuthenticationEvent {
  //TODO: save app state
}
