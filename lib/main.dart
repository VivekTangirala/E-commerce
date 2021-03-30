import 'dart:io';

import 'package:ecom/components/Themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Login/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Think Big',
        theme: basicTheme(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
