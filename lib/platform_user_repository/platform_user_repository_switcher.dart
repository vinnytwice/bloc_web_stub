import 'package:firebaseblocwebstub/platform_user_repository/platform_user_repository_stub.dart'
    if (dart.library.io) 'package:firebaseblocwebstub/platform_user_repository/platform_user_repository_device.dart'
    if (dart.library.js) 'package:firebaseblocwebstub/platform_user_repository/platform_user_repository_web.dart';

abstract class UserRepositorySwitcher {
  Future<dynamic> signInWithGoogle() async {
    print('UserREpository switcher signInWithGoogle() called');
  }

  Future<void> signInWithCredential({String email, String password}) {}
  Future<void> signUp({String email, String password}) {}
  Future<void> signOut() async {}
  Future<bool> isSignedIn() async {}
  Future<dynamic> getUser() async {}

  factory UserRepositorySwitcher() => getUserRepository();
}
