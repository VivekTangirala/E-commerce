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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFe74c3c), Color(0xFFF09819)],
                  begin: Alignment.center,
                  end: Alignment.bottomRight),
            ),
            child: _isLoading
                ? SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )))
                : ListView(children: <Widget>[
                    companyName(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: enterOTP(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 100,
                        height: 60,
                        child: TextField(
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 4,
                          decoration: InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            enabledBorder: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          controller: otpController,
                          cursorColor: Colors.white,
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
      margin: EdgeInsets.only(top: 45.0, bottom: 3),
      child: RaisedButton(
          color: Colors.green,
          child: Text("Confirm", style: TextStyle(color: Colors.white)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          onPressed: () {
            setState(() {
              _isLoading=true;
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
        _isLoading=false;
      });
      showDialog(
        
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Error",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              content: Text(
                jsonResponse["detail"],
                style: TextStyle(fontSize: 20),
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
              title: Text("Error",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              content: Text(
                jsonResponse["detail"],
                style: TextStyle(fontSize: 20),
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
        return Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 30),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              color: Colors.green,
              textColor: Colors.white,
              child: Center(
                  child: snapshot.data == 0
                      ? Text('resend OTP')
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                ' Try after ${snapshot.hasData ? snapshot.data.toString() : 30} seconds '),
                          ],
                        )),
              onPressed: snapshot.data == 0
                  ? () {
                      setState(() {
                        _isLoading = true;
                      });
                      sendOTP(phone);
                      _timerStream.sink.add(30);
                      activeCounter();
                    }
                  : null,
            ));
      },
    ));
  }
}

Container enterOTP() {
  return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Container(
        child: Text("Enter OTP",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
      ));
}

Container companyName() {
  return Container(
      margin: EdgeInsets.only(top: 35.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Container(
        child: Text("Infinity Mart",
            style: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.bold)),
      ));
}
