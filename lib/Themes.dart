import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basictext(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: base.headline2.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline3: base.headline3.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: base.headline4.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.grey[800],
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      headline5: base.headline5.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
      ),
      subtitle1: base.subtitle1.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.grey[800],
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.grey[800],
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basictext(base.textTheme),
      primaryColor: Color(0xffe75c3c),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 20.0,
      ));
}
