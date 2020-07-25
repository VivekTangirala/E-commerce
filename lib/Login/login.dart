import 'dart:convert';
import 'dart:async';

import 'package:ecom/Login/phone_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ecom/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  void initState() {
    super.initState();
    // checkSkip();
  }

  // Future checkSkip() async {
  //   SharedPreferences skip = await SharedPreferences.getInstance();
  //   //bool _seen = (skip.getBool('seen') ?? false);

  // }

  Future setSkip() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('seen', true);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFe74c3c), Color(0xFFF09819)],
              begin: Alignment.center,
              end: Alignment.bottomRight),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))
            : ListView(
                children: <Widget>[
                  skipSection(),
                  Align(

                    alignment: Alignment.center,
                    child: headerSection(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: textSection(),
                  ),
                  buttonSection(),
                  newAccountbutton(),
                ],
              ),
      ),
    );
  }

  //Header Handling

  Container headerSection() {
    return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Container(
          child: Text(" Infinity Mart",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold)),
        ));
  }

  signIn(String phone, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': phone, 'password': password};
    var jsonResponse;
    var response = await http
        .post("https://infintymall.herokuapp.com/user/api/login", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
          //print(jsonResponse);
        });
        sharedPreferences.setString("token", jsonResponse["token"]);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Error",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              content: Text(
                "Invalid Credintials",
                style: TextStyle(fontSize: 20),
              ),
            );
          });
      
    }
  }

  //Text Handling

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: phoneController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.white),
              hintText: "phone",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //Button Handling
  Container skipSection() {
    return Container(
        //width: MediaQuery.of(context).size.width,
        height: 40.0,
        alignment: Alignment.topRight,
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        margin: EdgeInsets.only(top: 26.0, bottom: 3),
      
          child: RaisedButton(
            onPressed: () async {
              await setSkip();
              Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
            (Route<dynamic> route) => false);
      }
            ,
            elevation: 0.0,
            color: Colors.green,
            child: Text("Skip Login", style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.only(top: 45.0, bottom: 3),
      child: RaisedButton(
        onPressed: phoneController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(phoneController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.green,
        child: Text("Sign In", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container newAccountbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.only(top: 75.0, bottom: 3),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignupPage()),
          );
        },
        elevation: 0.0,
        color: Colors.green,
        child: Text("Create New Account   ?",
            style: TextStyle(color: Colors.white)),
            
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
}
