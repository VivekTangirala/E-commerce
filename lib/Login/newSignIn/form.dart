import 'dart:async';
import 'dart:convert';
import 'package:ecom/Login/Forgotpass/phonenumber/phonenumber.dart';
import 'package:ecom/Login/components/constants.dart';
import 'package:ecom/Login/components/formerror.dart';
import 'package:ecom/components/screensize.dart';
import 'package:ecom/Login/components/skipbutton.dart';
import 'package:ecom/Login/components/suffix.dart';
import 'package:ecom/bottom_nav.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _doSomething() async {
    Timer(Duration(seconds: 2), () {
      _btnController.reset();
    });
  }

  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildphoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(70)),
          RoundedLoadingButton(
            child: rowfield(),
            color: Colors.deepOrange,
            controller: _btnController,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                await signIn(emailController.text, passwordController.text);
              } else {
                _doSomething();
                _btnController.error();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: getProportionateScreenWidth(30)),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PhoneNumber(value: 1)));
              },
              child: Text(
                "Forgot Password",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row rowfield() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text('Sign In', style: TextStyle(color: Colors.white)),
        Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(100))),
        Icon(
          EvaIcons.logIn,
          color: Colors.white,
        ),
        Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(30))),
      ],
    );
  }

  TextFormField buildphoneFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        } else if (phoneValidatorRegExp.hasMatch(value)) {
          setState(() {
            removeError(error: kInvalidPhoneNumber);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kInvalidPhoneNumber);
        } else if (!phoneValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidPhoneNumber);
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        labelText: "Phone number",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: new BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);

          return "";
        } else if (value.length < 3) {
          addError(error: kShortPassError);

          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Enter Password",
        fillColor: Colors.white,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: new BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Future signIn(String phone, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': phone, 'password': password};
    var jsonResponse;
    var response = await http
        .post("https://infintymall.herokuapp.com/user/api/login", body: data);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        _btnController.success();
        sharedPreferences.setString("token", "Token " + jsonResponse["token"]);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
            (Route<dynamic> route) => false);
      }
    } else {
      _btnController.error();
      setState(() {
        errors.clear();
      });
      addError(error: kinvalidcredentials);
      _doSomething();
      _btnController.error();
    }
  }
}
