import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseblocwebstub/authentication_bloc/app_user.dart';
import 'package:firebaseblocwebstub/platform_user_repository/platform_user_repository_switcher.dart';
import 'package:google_sign_in/google_sign_in.dart';

// using stub

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  UserRepositorySwitcher _repositorySwitcher = UserRepositorySwitcher();

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<dynamic> signInWithGoogle() async {
    print('userRepository stub  signInWithGoogle() called');
    await _repositorySwitcher.signInWithGoogle();
  }

  Future<void> signInWithCredential({String email, String password}) async {
    await _repositorySwitcher.signInWithCredential(
        email: email, password: password);
  }

  Future<void> signUp({String email, String password}) async {
    await _repositorySwitcher.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await _repositorySwitcher.signOut();
  }

  Future<bool> isSignedIn() async {
    await _repositorySwitcher.isSignedIn();
  }

  Future<FixitUser> getUser() async {
    return await _repositorySwitcher.getUser();
//    String displayName = (await _firebaseAuth.currentUser()).displayName;
//    String email = (await _firebaseAuth.currentUser()).email;
//    String uid = (await _firebaseAuth.currentUser()).uid;
//    String photoUrl = (await _firebaseAuth.currentUser()).photoUrl;
//    String phoneNumber = (await _firebaseAuth.currentUser()).phoneNumber;
//    FixitUser user = FixitUser(
//      // fixitUser
//        name: displayName ?? '',
//        email: email,
//        phoneNumber: phoneNumber ?? '',
//        uid: uid,
//        photoUrl: photoUrl ?? '');
//    return (user);
  }
}

// using same repo both for web and device
//class UserRepository {
//  final FirebaseAuth _firebaseAuth;
//  final GoogleSignIn _googleSignIn;
//
//  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
//      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
//        _googleSignIn = googleSignIn ?? GoogleSignIn();
//
//  Future<FirebaseUser> signInWithGoogle() async {
//    print('signInWithGoogle() started');
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    print('GoogleUser is : $googleUser');
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
//    final AuthCredential credential = await GoogleAuthProvider.getCredential(
//        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//    await _firebaseAuth.signInWithCredential(credential);
//    return _firebaseAuth.currentUser();
//  }
//
//  Future<void> signInWithCredential({String email, String password}) {
//    return _firebaseAuth.signInWithEmailAndPassword(
//        email: email, password: password);
//  }
//
//  Future<void> signUp({String email, String password}) {
//    return _firebaseAuth.createUserWithEmailAndPassword(
//        email: email, password: password);
//  }
//
//  Future<void> signOut() async {
//    return Future.wait([
//      _firebaseAuth.signOut(),
//      _googleSignIn.signOut(),
//    ]);
//  }
//
//  Future<bool> isSignedIn() async {
//    final currentUser = _firebaseAuth.currentUser();
//    return currentUser != null;
//  }
//
//  Future<FixitUser> getUser() async {
//    String displayName = (await _firebaseAuth.currentUser()).displayName;
//    String email = (await _firebaseAuth.currentUser()).email;
//    String uid = (await _firebaseAuth.currentUser()).uid;
//    String photoUrl = (await _firebaseAuth.currentUser()).photoUrl;
//    String phoneNumber = (await _firebaseAuth.currentUser()).phoneNumber;
//    FixitUser user = FixitUser(
//        // fixitUser
//        name: displayName ?? '',
//        email: email,
//        phoneNumber: phoneNumber ?? '',
//        uid: uid,
//        photoUrl: photoUrl ?? '');
//    return (user);
//  }
//}
