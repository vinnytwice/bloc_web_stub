//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebaseblocwebstub/authentication_bloc/app_user.dart';
//import 'package:firebaseblocwebstub/platform_user_repository/platform_user_repository_switcher.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//class UserRepositoryWeb implements UserRepositorySwitcher {
//  final FirebaseAuth _firebaseAuth;
//  final GoogleSignIn _googleSignIn;
//
//  UserRepositoryWeb({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
//      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
//        _googleSignIn = googleSignIn ?? GoogleSignIn();
//
//  Future<FirebaseUser> signInWithGoogle() async {
//    print('signInWithGoogle() from web started');
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
//
//UserRepositorySwitcher getUserRepository() => UserRepositoryWeb();
import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:firebaseblocwebstub/authentication_bloc/app_user.dart';
import 'package:firebaseblocwebstub/firebase_singleton.dart';
import 'package:firebaseblocwebstub/platform_user_repository/platform_user_repository_switcher.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositoryWeb implements UserRepositorySwitcher {
  App firebase = FirebaseWeb.instance.app;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    print('signInWithGoogle() started');
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print('GoogleUser is : $googleUser');
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = await GoogleAuthProvider.credential(
        googleAuth.idToken, googleAuth.accessToken);
    // singleton retunrning Future<App>
//    await firebase.then((firebase) {
//      firebase.auth().signInWithCredential(credential);
//      return;
//    });
//    return firebase.then((firebase) {
//      return firebase.auth().currentUser;
//    });

    await firebase.auth().signInWithCredential(credential);
    return firebase.auth().currentUser;
  }

  Future<void> signInWithCredential({String email, String password}) {
    return firebase.auth().signInWithEmailAndPassword(email, password);
    // singleton retunrning Future<App>
//    return firebase.then((firebase) {
//      return firebase.auth().signInWithEmailAndPassword(email, password);
//    });
  }

  Future<void> signUp({String email, String password}) {
    return firebase.auth().createUserWithEmailAndPassword(email, password);
    // singleton retunrning Future<App>
//    return firebase.then((firebase) {
//      return firebase.auth().createUserWithEmailAndPassword(email, password);
//    });
  }

  Future<void> signOut() async {
    return Future.wait([
      firebase.auth().signOut(),
// singleton retunrning Future<App>
//      firebase.then((firebase) {
//        firebase.auth().signOut();
//      }),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = firebase.auth().currentUser;
    return currentUser != null;
    // singleton retunrning Future<App>
//    User firebaseUser = firebase.then((firebase) {
//      return firebase.auth().currentUser;
//    }) as User;
//    return firebaseUser != null;
  }

  Future<FixitUser> getUser() async {
    // singleton retunrning Future<App>
//    User firebaseUser = firebase.then((firebase) {
//      return firebase.auth().currentUser;
//    }) as User;
//
//    FixitUser user = FixitUser(
//        name: firebaseUser.displayName ?? '',
//        email: firebaseUser.email,
//        phoneNumber: firebaseUser.phoneNumber ?? '',
//        uid: firebaseUser.uid,
//        photoUrl: firebaseUser.photoURL ?? '');
//    return (user);
//  }
    String displayName = (firebase.auth().currentUser).displayName;
    String email = (firebase.auth().currentUser).email;
    String uid = (firebase.auth().currentUser).uid;
    String photoUrl = (firebase.auth().currentUser).photoURL;
    String phoneNumber = (firebase.auth().currentUser).phoneNumber;

    FixitUser user = FixitUser(
        name: displayName ?? '',
        email: email,
        phoneNumber: phoneNumber ?? '',
        uid: uid,
        photoUrl: photoUrl ?? '');
    return (user);
  }
}

UserRepositorySwitcher getUserRepository() => UserRepositoryWeb();
