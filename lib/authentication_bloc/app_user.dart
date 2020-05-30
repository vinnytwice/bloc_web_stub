import 'package:flutter/material.dart';

class FixitUser {
  final String name;
  final String email;
  final String phoneNumber;
  final String uid;
  final String photoUrl;
  const FixitUser(
      {@required this.name,
      @required this.email,
      @required this.phoneNumber,
      @required this.uid,
      @required this.photoUrl});

  @override
  List<Object> get props => [name, email, phoneNumber, uid, photoUrl];

  @override
  String toString() =>
      'User { displayName: $name, email: $email, phone number:$phoneNumber, uid: $uid, photoUrl: $photoUrl}';
}
