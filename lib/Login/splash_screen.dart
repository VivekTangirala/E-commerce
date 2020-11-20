import 'dart:async';
import 'package:ecom/Homepage/homefragment.dart';
import 'package:ecom/Login/newSignIn/signin.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String _login = (sharedPreferences.getString('token') ?? null);

    if (_seen || _login!=null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeFragment()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color _thisColor1 = Color(0xFFe74c3c);
    // Color _thisColor2 =Color(0xFFF09819);
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xffe75c3c), Color(0xfff09819)],
            begin: Alignment.center,
            end: Alignment.bottomRight),
      ),
      child: Center(
        child: headerSection(context),
      ),
    ));
  }
}

Container headerSection(BuildContext context) {
  return Container(
      //margin: EdgeInsets.only(top: 50.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              " Infinity Mart",
              style: Theme.of(context).textTheme.headline1.copyWith(fontSize: getProportionateScreenWidth(40)),
            ),
            Icon(
              Icons.shopping_cart,
              size: getProportionateScreenWidth(60),
              color: Colors.black,
            )
          ],
        ),
      ));
}
