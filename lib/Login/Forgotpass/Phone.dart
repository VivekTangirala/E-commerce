import 'dart:convert';
import 'package:ecom/Login/Forgotpass/Confirmotp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../login.dart';
import '../otp.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
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
                  SizedBox(height: 70.0),
                  getting_started(),
                  SizedBox(height: 10.0),
                  getting_started1(),
                  textSection(),
                  senOTPButton(),
                  SizedBox(height: 50.0),
                ],
              ),
      ),
    );
  }
  //Header Handling

  Widget getting_started() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        "Enter Phone number",
        style: Theme.of(context)
            .textTheme
            .headline3
            .copyWith(color: Colors.orange),
      ),
    );
  }

  Widget getting_started1() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 50),
      padding: EdgeInsets.only(left: 18.0),
      child: Text(
        "An OTP will be sent to this mobile number",
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(fontWeight: FontWeight.normal),
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
          MaterialPageRoute(builder: (context) => Confirmotp(phone: phone)),
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
                color: Colors.orangeAccent,
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
      height: 60.0,
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

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
}
