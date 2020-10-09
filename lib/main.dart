import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gallery_test/app/ui/scene/splash_screen/splash_screen.dart';
import 'package:gallery_test/app/ui/scene/welcome_screen/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// TODO ???
    /// всё что ниже лучше в мэйн
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Firebase.initializeApp();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(home: WelcomeScreen()),
    );
  }
}
