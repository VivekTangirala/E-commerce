import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import './login.dart';
import './otp.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Color(0xFFe74c3c), Color(0xFFF09819)],
        //       begin: Alignment.top,
        //       end: Alignment.bottomRight),
        // ),
        child: _isLoading
            ? SizedBox(
                child: Center(
                    child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )))
            : ListView(
                children: <Widget>[
                  skipSection(),
                  SizedBox(height: 30.0),
                  getting_started(),
                  getting_started1(),
                  textSection(),
                  senOTPButton(),
                  SizedBox(height: 50.0),
                  loginAccountbutton(),
                ],
              ),
      ),
    );
  }
  //Header Handling

  Widget skipSection() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))),
        //width: MediaQuery.of(context).size.width,
        height: 100.0,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        margin: EdgeInsets.only(top: 0.0, bottom: 3),
        child: Text(
          "Create Account",
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: Colors.white, fontSize: 25.0, letterSpacing: 1.5),
        ));
  }

  Widget getting_started() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        " Getting started",
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget getting_started1() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 50),
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        " Create an account to continue",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  sendOTP(String phone) async {
    Map data = {'phone': phone};
    var jsonResponse;
    var response = await http.post(
        "https://infintymall.herokuapp.com/user/api/register/mobile",
        body: data);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
          print(jsonResponse);
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen(phone: phone)),
        );
        print(jsonResponse);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                " Error",
                style: Theme.of(context).textTheme.headline4,
              ),
              content: Text(
                "${jsonResponse["detail"]}",
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          });
      print(response.body);
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
          TextField(
            controller: phoneController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.black),
              hintText: "phone",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xffe75c3c),
              )),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  //Button Handling

  Container senOTPButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.only(top: 45.0, bottom: 3),
      child: RaisedButton(
        onPressed: phoneController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });

                if (phoneController.text.length < 8 ||
                    phoneController.text.length > 12) {
                  setState(() {
                    _isLoading = false;
                  });
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            "Error",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          content: Text(
                            "Invalid Number",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        );
                      });
                } else {
                  sendOTP(phoneController.text);
                }
              },
        elevation: 0.0,
        color: Colors.orangeAccent,
        child: Text("Continue",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Widget loginAccountbutton() {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Signin",
                    style: Theme.of(context).textTheme.headline2.copyWith(color:Colors.orangeAccent),
                  )
                ]),
          ),
        ));
  }

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
}
