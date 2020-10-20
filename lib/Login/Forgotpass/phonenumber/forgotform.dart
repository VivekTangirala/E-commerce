import 'dart:async';
import 'dart:convert';
import 'package:ecom/Login/otp.dart';
import 'package:http/http.dart' as http;
import 'package:ecom/Login/Forgotpass/Confirmotp.dart';
import 'package:ecom/Login/components/constants.dart';
import 'package:ecom/Login/components/formerror.dart';
import 'package:ecom/Login/components/noaccount.dart';
import 'package:ecom/Login/components/suffix.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String phone;

  void _doSomething() async {
    Timer(Duration(seconds: 2), () {
      _btnController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          phonetextfeild(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          RoundedLoadingButton(
            child: Text('Send OTP', style: TextStyle(color: Colors.white)),
            color: Colors.deepOrange,
            controller: _btnController,
            onPressed: () async {

              if (_formKey.currentState.validate() &&
                  _controller.text.length == 10 ) {
                await sendOTP(_controller.text);
                _doSomething();
                _btnController.error();
              } else {
                _doSomething();
                _btnController.error();
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }

  phonetextfeild() {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPhoneNullError)) {
          setState(() {
            errors.remove(kPhoneNullError);
          });
        } else if (!phoneValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidPhoneNumber)) {
          setState(() {
            errors.remove(kInvalidPhoneNumber);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPhoneNullError)) {
          setState(() {
            errors.add(kPhoneNullError);
          });
          return " ";
        } else if (!phoneValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidPhoneNumber)) {
          setState(() {
            errors.add(kInvalidPhoneNumber);
          });
          return " ";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone number",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  sendOTP(String phone) async {
    print(phone);
    Map data = {'phone': phone};
    var jsonResponse;
    var response = await http.post(
        "https://infintymall.herokuapp.com/user/api/register/mobile",
        body: data);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        print(jsonResponse);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Confirmotp(phone: phone,value: 0,)),
        );
      }
    } else {
      setState(() {
        errors.add(jsonResponse["detail"]);
      });

      print(response.body);
    }
  }
}
