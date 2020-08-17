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
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ))
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
                  newAccountbutton()
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
          child: Text(
            " Infinity Mart",
            style: Theme.of(context).textTheme.headline1,
          ),
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
              title:
                  Text("Error", style: Theme.of(context).textTheme.headline2),
              content: Text(
                "Invalid Credintials!",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          });
    }
  }
  //getting started section
// Widget getting_started() {
//     return Container(
//       alignment: Alignment.topLeft,
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.only(left: 20.0),
//       child: Text(
//         "",
//         style: Theme.of(context).textTheme.headline3,
//       ),
//     );
//   }

//   Widget getting_started1() {
//     return Container(
//       alignment: Alignment.topLeft,
//       margin: EdgeInsets.only(bottom: 50),
//       padding: EdgeInsets.only(left: 20.0),
//       child: Text(
//         " Create an account to continue",
//         style: Theme.of(context).textTheme.headline4,
//       ),
//     );
//   }
//Text Handling

  Container textSection() {
    return Container(
      margin: EdgeInsets.only(bottom:50.0),
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
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.black),
              hintText: "phone",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.black),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  //Button Handling
  Widget skipSection() {
    return InkWell(
        onTap: () async {
          await setSkip();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
              (Route<dynamic> route) => false);
        },
        child: Container(
            //width: MediaQuery.of(context).size.width,
            height: 40.0,
            alignment: Alignment.topRight,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            margin: EdgeInsets.only(top: 26.0, bottom: 3),
            child: Text(
              "Skip login",
              style: Theme.of(context).textTheme.headline2,
            )));
  }

  Container buttonSection() {
    return Container(
      decoration: BoxDecoration(),
      //width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
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
        color: Color(0xffe74c3c),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text("Sign in", style: Theme.of(context).textTheme.headline2.copyWith(color:Colors.white)),
          SizedBox(width:20.0),
          Icon(
            Icons.exit_to_app,
            color: Colors.white,
          )
        ]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Widget newAccountbutton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        margin: EdgeInsets.only(top: 45.0, bottom: 3),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            "Don't have an account?",
            style: Theme.of(context).textTheme.headline5,
          ),
          
          Text(
            "Signup",
            style: Theme.of(context).textTheme.headline2,
          )
        ]),
      ),
    );
  }

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
}
