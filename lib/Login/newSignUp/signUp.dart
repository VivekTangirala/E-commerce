import 'package:flutter/material.dart';

import 'body.dart';

class SignUpScreen extends StatelessWidget {
  final  phone;

  const SignUpScreen({Key key, this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Body(phone: phone));
  }
}
