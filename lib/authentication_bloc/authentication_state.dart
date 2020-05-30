import 'package:equatable/equatable.dart';
import 'package:firebaseblocwebstub/authentication_bloc/app_user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final FixitUser user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { displayName: $user}';
}

class Unauthenticated extends AuthenticationState {}
