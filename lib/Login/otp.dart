import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './register.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({Key key, this.phone}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState(phone);
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoading = false;
  final TextEditingController otpController = new TextEditingController();
  static const _timerDuration = 30;
  StreamController _timerStream = new StreamController<int>.broadcast();

  int timerCounter;
  Timer _resendCodeTimer;
  String phone;
  _OtpScreenState(this.phone);

  @override
  void initState() {
    activeCounter();

    super.initState();
  }

  @override
  void dispose() {
    _timerStream.close();
    _resendCodeTimer.cancel();

    super.dispose();
  }

  activeCounter() {
    _resendCodeTimer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_timerDuration - timer.tick > 0)
        _timerStream.sink.add(_timerDuration - timer.tick);
      else {
        _timerStream.sink.add(0);
        _resendCodeTimer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       colors: [Color(0xFFe74c3c), Color(0xFFF09819)],
            //       begin: Alignment.center,
            //       end: Alignment.bottomRight),
            // ),
            child: _isLoading
                ? SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )))
                : ListView(children: <Widget>[
                    companyName(context),
                    Align(
                      alignment: Alignment.topCenter,
                      child: enterOTP(context),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 100,
                        height: 60,
                        child: TextField(
                          style: TextStyle(color:Colors.black),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 4,
                          decoration: InputDecoration(
                            
                            filled: true,
                            //fillColor: Colors.black,
                            enabledBorder: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          controller: otpController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          // end onSubmit
                        ),
                      ),
                    ),
                    confirmButton(),
                    resendOTPButton(),
                  ])));
  }

  Container confirmButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      child: RaisedButton(
          color: Colors.grey,
          child: Text("Confirm", style: Theme.of(context).textTheme.headline2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            registerOTP(otpController.text.toString());
          }),
    );
  }

  registerOTP(String pin) async {
    Map data = {'phone': phone, 'otp': pin};
    var jsonResponse;
    var response;
    response = await http.post(
        "https://infintymall.herokuapp.com/user/api/register/mobile/otp",
        body: data);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => RegisterPage(phone: phone)),
            (Route<dynamic> route) => false);
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
              title:
                  Text("Error", style: Theme.of(context).textTheme.headline2),
              content: Text(
                jsonResponse["detail"],
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          });
      print(response.body);
    }
  }

  sendOTP(String phone) async {
    Map data = {'phone': phone};
    var jsonResponse;
    var response;
    response = await http.post(
        "https://infintymall.herokuapp.com/user/api/register/mobile",
        body: data);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
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
              title:
                  Text("Error", style: Theme.of(context).textTheme.headline2),
              content: Text(
                jsonResponse["detail"],
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          });
      print(response.body);
    }
  }

  Container resendOTPButton() {
    return Container(
        // width: MediaQuery.of(context).size.width,

        child: StreamBuilder(
      stream: _timerStream.stream,
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        return InkWell(
            onTap: snapshot.data == 0
                ? () {
                    setState(() {
                      _isLoading = true;
                    });
                    sendOTP(phone);
                    _timerStream.sink.add(30);
                    activeCounter();
                  }
                : null,
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: snapshot.data == 0
                    ? Text(
                        'Resend OTP?',
                        style: Theme.of(context).textTheme.headline2,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            ' Try after ${snapshot.hasData ? snapshot.data.toString() : 30} seconds ',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
              ),
            ));
      },
    ));
  }
}

Container enterOTP(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Container(
        child: Text(
          "Enter OTP",
          style: Theme.of(context).textTheme.headline3,
        ),
      ));
}

Container companyName(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 35.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Center(
        child:
            Text("Infinity Mart", style: Theme.of(context).textTheme.headline1),
      ));
}
