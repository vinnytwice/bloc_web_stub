//import 'dart:async';
//import 'package:firebase/firebase.dart';

//class FirebaseProvider {
//  // Singleton instance
//  static final FirebaseProvider _singleton = FirebaseProvider._();
//
//  // Singleton accessor
//  static FirebaseProvider get instance => _singleton;
//
//  // Completer is used for transforming synchronous code into asynchronous code.
//  Completer<??> _dbOpenCompleter;
//
//  // A private constructor. Allows us to create instances of AppDatabase
//  // only from within the AppDatabase class itself.
//  FirebaseProvider._();
//
//  // Sembast database object
////  Database _database;
//
//  // Database object accessor
//  Future<?> get database async {
//    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
//    if (_dbOpenCompleter == null) {
//      _dbOpenCompleter = Completer();
//      // Calling _openDatabase will also complete the completer with database instance
//      _openDatabase();
//    }
//    // If the database is already opened, awaiting the future will happen instantly.
//    // Otherwise, awaiting the returned future will take some time - until complete() is called
//    // on the Completer in _openDatabase() below.
//    return _dbOpenCompleter.future;
//  }
//
//  Future _openDatabase() async {
//    if (kIsWeb) {
//      final dbPath = 'device.db';
//      final factory = databaseFactoryWeb;
//      final database = await factory.openDatabase(dbPath);
//      // Any code awaiting the Completer's future will now start executing
//      _dbOpenCompleter.complete(database);
//    } else {
//      final appDocumentDir = await getApplicationDocumentsDirectory();
//      final dbPath = join(appDocumentDir.path, 'device.db');
//      final factory = databaseFactoryIo;
//      final database = await factory.openDatabase(dbPath);
//      // Any code awaiting the Completer's future will now start executing
//      _dbOpenCompleter.complete(database);
//    }
//  }
//}
import 'dart:async';
import 'package:firebase/firebase.dart';

class FirebaseWeb {
  // Singleton instance
  static final FirebaseWeb _singleton = FirebaseWeb._();

  // Singleton accessor
  static FirebaseWeb get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<App> _dbOpenCompleter;

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  FirebaseWeb._();

  static App _app;
  // Database object accessor

  App get app {
    print('firebase get app called ');
    print('_app is $_app');
    if (_app != null) {
      return _app;
    } else {
      print('initialize app');
      _app = initializeApp(
          apiKey: "PUT_YOUR_KEY",
          authDomain: "PUT_YOUR_KEY",
          databaseURL: "PUT_YOUR_KEY",
          projectId: "PUT_YOUR_KEY",
          storageBucket: "PUT_YOUR_KEY",
          messagingSenderId: "PUT_YOUR_KEY",
          appId: "PUT_YOUR_KEY");
      print('initialized app is $_app'); // await _initializeApp();
      return _app;
    }
  }
}
