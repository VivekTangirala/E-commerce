import 'dart:async';
import 'dart:convert';
import 'package:ecom/Login/newSign/constants.dart';
import 'package:ecom/Login/newSign/defaultbutton.dart';
import 'package:ecom/Login/newSign/formerror.dart';
import 'package:ecom/Login/newSign/screensize.dart';
import 'package:ecom/Login/newSign/skipbutton.dart';
import 'package:ecom/Login/newSign/suffix.dart';
import 'package:ecom/bottom_nav.dart';
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
  bool remember = false, _isLoading = false;
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              SkipSection(),
              Spacer(),
              GestureDetector(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.deepOrange),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(80)),
          RoundedLoadingButton(
            child: Text('Sign In', style: TextStyle(color: Colors.white)),
            color: Colors.deepOrange,
            controller: _btnController,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

              await  signIn(emailController.text, passwordController.text);
                _doSomething();
                _btnController.error();
              } else {
                _doSomething();
                _btnController.error();
              }
            },
          ),
        ],
      ),
    );
  }

  void _doSomething() async {
    Timer(Duration(seconds: 2), () {
      _btnController.reset();
    });
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (phoneValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);

          return "";
        } else if (!phoneValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);

          return "";
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
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
      setState(() {
        _isLoading = false;
      });
      _btnController.error();
      _btnController.reset();
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title:
                  Text("Error", style: Theme.of(context).textTheme.headline2),
              content: Text(
                "Invalid Credintials!",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          });
    }
  }
}
