import 'dart:async';
import 'dart:convert';
import 'package:ecom/Login/Forgotpass/Newpass.dart';
import 'package:ecom/Login/Forgotpass/passwordchange/passbody.dart';
import 'package:ecom/Login/components/formerror.dart';
import 'package:ecom/Login/newSignUp/signUp.dart';
import 'package:ecom/components/screensize.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';

class Confirmotp extends StatefulWidget {
  final value;

  final String phone;

  const Confirmotp({Key key, this.phone, this.value}) : super(key: key);
  @override
  _ConfirmotpState createState() => _ConfirmotpState(phone, value);
}

class _ConfirmotpState extends State<Confirmotp> {
  bool _isLoading = false;
  List<String> errors = [];
  final TextEditingController otpController = new TextEditingController();
  static const _timerDuration = 30;
  StreamController _timerStream = new StreamController<int>.broadcast();

  int timerCounter, value;
  Timer _resendCodeTimer;
  String phone;
  List a = [
    "https://infintymall.herokuapp.com/user/api/register/mobile/otp",
    "https://infintymall.herokuapp.com/user/api/register/mobile/otp"
  ];
  _ConfirmotpState(this.phone, this.value);

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
            child: _isLoading
                ? SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )))
                : ListView(children: <Widget>[
                    heading(context),
                    subHeading(context),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    Align(
                      alignment: Alignment.topCenter,
                      child: enterOTP(context, phone),
                    ),
                    OTPTextField(
                      length: 4,
                      width: 100,
                      fieldWidth: 50,
                      style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,
                      onCompleted: (pin) {
                        setState(() {
                          _isLoading = true;
                        });
                        registerOTP(pin);
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.1,
                    ),
                    FormError(errors: errors),
                    resendOTPButton(),
                  ])));
  }

  registerOTP(String pin) async {
    Map data = {'phone': phone, 'otp': pin};
    var jsonResponse;
    var response;
    response = await http.post(
        a[0],
        body: data);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) =>value==1? NewPassword():SignUpScreen()),
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
              title:
                  Text("Error", style: Theme.of(context).textTheme.headline2),
              content: Text(
                jsonResponse["detail"],
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          });
      print(response.body);
      pin = "";
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
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.deepOrange),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              ' Try after ${snapshot.hasData ? snapshot.data.toString() : 30} seconds ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: Colors.deepOrange)),
                        ],
                      ),
              ),
            ));
      },
    ));
  }
}

Container enterOTP(BuildContext context, String phone) {
  return Container(
      margin: EdgeInsets.only(top: 0.0, bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
      child: Container(
        child: Text(
          "Enter OTP sent to " + phone,
          style: Theme.of(context).textTheme.headline3.copyWith(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ));
}

Container heading(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(
        top: 35.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text("Verify OTP",
            style: Theme.of(context).textTheme.headline1.copyWith(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
      ));
}

Container subHeading(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 6.0, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text(
            "Enter otp received to continue\n   to change your password",
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: Colors.grey[600], fontSize: 16.0)),
      ));
}
