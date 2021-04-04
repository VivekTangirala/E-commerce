import 'dart:async';
import 'dart:convert';
import 'package:ecom/Login/newSignIn/signin.dart';
import 'package:ecom/bottom_nav.dart';
import 'package:http/http.dart' as http;
import 'package:ecom/Login/components/constants.dart';
import 'package:ecom/Login/components/formerror.dart';
import 'package:ecom/Login/components/suffix.dart';
import 'package:ecom/components/screensize.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpForm extends StatefulWidget {
  final  phone;

  const SignUpForm({Key key, this.phone}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState(phone);
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email, name, phone;
  String password;
  String conformPassword;
  bool remember = false;
  final List<String> errors = [];
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  _SignUpFormState(this.phone);
  void _stopbutton() async {
    Timer(Duration(seconds: 2), () {
      _btnController.reset();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          RoundedLoadingButton(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text('Register', style: TextStyle(color: Colors.white)),
                Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(100))),
                Icon(
                  EvaIcons.logIn,
                  color: Colors.white,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(30))),
              ],
            ),
            color: Colors.deepOrange,
            controller: _btnController,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                registerUser(name, email, password, conformPassword);
              } else {
                _stopbutton();
                _btnController.start();
              }
            },
          ),
        ],
      ),
    );
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
    print(jsonResponse);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        _btnController.success();
        print(jsonResponse["token"]);
        sharedPreferences.setString("token", jsonResponse["token"]);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => SignInScreen()),
            (Route<dynamic> route) => false);
      }
    } else {
      _btnController.reset();

      var a = jsonResponse["detail"];
      print(a);
      a != null ? errors.add(a) : errors.add("error");
    }
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        fillColor: Colors.white,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: new BorderSide(),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        fillColor: Colors.white,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: new BorderSide(),
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(

      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        } 
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } 
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        fillColor: Colors.white,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: new BorderSide(),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        fillColor: Colors.white,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: new BorderSide(),
        ),
      ),
    );
  }
}
