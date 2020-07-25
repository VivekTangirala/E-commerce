import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/Login/login.dart';
import 'package:ecom/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;
  bool a = false;

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(seconds: 1), () {
      checkFirstSeen();
    });
  }

  Future checkFirstSeen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool _seen = (sharedPreferences.getBool('seen') ?? false);

    if (_seen) {
          Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
        (Route<dynamic> route) => false);
    } else {
      
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color _thisColor1 = Color(0xFFe74c3c);
    // Color _thisColor2 =Color(0xFFF09819);
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFe74c3c), Color(0xFFF09819)],
                  begin: Alignment.center,
                  end: Alignment.bottomRight),
            ),
            child: headerSection()));
  }
}

Container headerSection() {
  return Container(
      //margin: EdgeInsets.only(top: 50.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Center(
        child: Text(" Infinity Mart",
            style: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.bold)),
      ));
}
