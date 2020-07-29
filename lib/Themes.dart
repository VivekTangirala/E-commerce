import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basictext(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 45.0,
        fontWeight: FontWeight.w600,
      ),
      headline2: base.headline2.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
      ),
      headline3: base.headline3.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.w500,
      ),
      headline4: base.headline4.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w500,
      ),
      headline5: base.headline5.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ),
      headline6: base.headline6.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: base.subtitle1.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ),
      subtitle2: base.subtitle2.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.grey[800],
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      caption: base.caption.copyWith(
        fontFamily: "DM_Sans",
        color: Colors.grey[800],
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
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
