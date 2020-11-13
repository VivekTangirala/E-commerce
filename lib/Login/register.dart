import 'dart:convert';
import 'package:ecom/bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  final String phone;

  const RegisterPage({Key key, this.phone}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState(phone);
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;

  String phone;
  _RegisterPageState(this.phone);

  void initState() {
    super.initState();
    // checkSkip();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Color(0xFFe74c3c), Color(0xFFF09819)],
        //       begin: Alignment.center,
        //       end: Alignment.bottomRight),
        // ),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ))
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
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
            child: Center(
          child: Text(
            "TREG",
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: Colors.orangeAccent),
          ),
        )));
  }

  registerUser(String name, email, password, password2) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password2': password2
    };
    var jsonResponse;
    var response = await http.post(
      "https://infintymall.herokuapp.com/user/api/register",
      body: data,
    );
    jsonResponse = json.decode(response.body.toString());
    if (response.statusCode == 200) {
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
      try {
        var a = jsonResponse["detail"];
        print(a);
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title:
                    Text("Error", style: Theme.of(context).textTheme.headline2),
                content: Text(
                  a == null ? '' : a,
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            });
      } on NoSuchMethodError {
        print(jsonResponse);
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title:
                    Text("Error", style: Theme.of(context).textTheme.headline2),
                content: Text(
                  "Invalid email",
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            });
      }
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
            controller: nameController,
            cursorColor: Colors.black,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle,
                  color: Colors.orangeAccent),
              hintText: "Full Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.orangeAccent),
              hintText: "Email",
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
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.orangeAccent),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: password2Controller,
            cursorColor: Colors.black,
            obscureText: true,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.orangeAccent),
              hintText: "Re-enter Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  //Button Handling

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: RaisedButton(
        onPressed: emailController.text == "" ||
                passwordController.text == "" ||
                password2Controller.text == '' ||
                nameController.text == ''
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                if (password2Controller.text.length < 8) {
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
                            "Minimum password length 8 characters",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        );
                      });
                } else if (passwordController.text ==
                        password2Controller.text &&
                    passwordController.text != null) {
                  registerUser(nameController.text, emailController.text,
                      passwordController.text, password2Controller.text);
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Error",
                              style: Theme.of(context).textTheme.headline2),
                          content: Text(
                            "please check the details",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        );
                      });
                }
              },
        elevation: 0.0,
        color: Colors.orangeAccent,
        child: Text("Sign Up",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  final TextEditingController password2Controller = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
}
