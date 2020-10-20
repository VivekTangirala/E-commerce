import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'body.dart';


class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }


}
