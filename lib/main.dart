import 'package:firebaseblocwebstub/authentication_bloc/bloc.dart';
import 'package:firebaseblocwebstub/authentication_bloc/user_repository.dart';
import 'package:firebaseblocwebstub/localization.dart';
import 'package:firebaseblocwebstub/login/login_screen.dart';
import 'package:firebaseblocwebstub/screens/main_screen.dart';
import 'package:firebaseblocwebstub/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

// flutter run -d chrome --release --web-hostname localhost --web-port 5000
// flutter run -d chrome --profile --web-hostname localhost --web-port 5000
// flutter run  -d chrome --profile --track-widget-creation --web-hostname localhost --web-port 5000

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('it', 'IT'),
        const Locale('es', 'ES'),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (kIsWeb) {
            Locale webLocale = ui.window.locale;

            print('system locale is $webLocale'); // always en_US
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              print('device Locale is $locale');
              return supportedLocale;
            }
////              return webLocale;
//          } else if (supportedLocale.languageCode == locale.languageCode ||
//              supportedLocale.countryCode == locale.countryCode) {
          } else if (supportedLocale.countryCode == locale.countryCode) {
            print('device Locale is $locale');
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MainScreen(
//                  deviceLocale: deviceLocale,
        );
  }
}
