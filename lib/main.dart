import 'dart:io';

import 'package:ecom/Themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Login/splash_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Think Big',
        theme: basicTheme(),
        
        home: SplashScreen());
  }
}
