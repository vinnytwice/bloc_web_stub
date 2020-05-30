//import 'package:firebase/firebase.dart';
//import 'package:firebase/src/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseblocwebstub/authentication_bloc/app_user.dart';
import 'package:firebaseblocwebstub/platform_user_repository/platform_user_repository_switcher.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositoryDevice implements UserRepositorySwitcher {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepositoryDevice({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    print('signInWithGoogle() from device started');
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print('GoogleUser is : $googleUser');
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = await GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredential({String email, String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp({String email, String password}) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FixitUser> getUser() async {
    String displayName = (await _firebaseAuth.currentUser()).displayName;
    String email = (await _firebaseAuth.currentUser()).email;
    String uid = (await _firebaseAuth.currentUser()).uid;
    String photoUrl = (await _firebaseAuth.currentUser()).photoUrl;
    String phoneNumber = (await _firebaseAuth.currentUser()).phoneNumber;
    FixitUser user = FixitUser(
        // fixitUser
        name: displayName ?? '',
        email: email,
        phoneNumber: phoneNumber ?? '',
        uid: uid,
        photoUrl: photoUrl ?? '');
    return (user);
  }
}

UserRepositorySwitcher getUserRepository() => UserRepositoryDevice();
