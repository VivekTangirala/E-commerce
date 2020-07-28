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
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFe74c3c), Color(0xFFF09819)],
              begin: Alignment.center,
              end: Alignment.bottomRight),
        ),
        child: _isLoading
            ?SizedBox(child:  
            Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )))
            : ListView(
                children: <Widget>[
                  loginAccountbutton(),
                  headerSection(),
                  SizedBox(height: 30.0),
                  textSection(),
                  senOTPButton(),
                ],
              ),
      ),
    );
  }

  //Header Handling

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(" Infinity Mart",
              style: Theme.of(context).textTheme.headline1,),
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
              title: Text(" Error",
              style: Theme.of(context).textTheme.headline4,),
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
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
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

                if (phoneController.text.length < 8||phoneController.text.length>12) {
                  setState(() {
                    _isLoading = false;
                  });
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Error",
                               style: Theme.of(context).textTheme.headline4,),
                          content: Text(
                            "Invalid Number",
                             style: Theme.of(context).textTheme.headline5,
                          ),
                        );
                      });
                } else {
                  sendOTP(phoneController.text);
                }
              },
        elevation: 0.0,
        color: Colors.green,
        child: Text("Send OTP", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container loginAccountbutton() {
    return Container(
      height: 40.0,
      alignment: Alignment.topRight,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.only(top: 26.0, bottom: 3),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        elevation: 0.0,
        color: Colors.green,
        child: Text("Already Have an Account  ?",
             style: Theme.of(context).textTheme.headline4,),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
}
