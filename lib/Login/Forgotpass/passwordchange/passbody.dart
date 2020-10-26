import 'package:ecom/Login/Forgotpass/passwordchange/body.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  final phone;

  const NewPassword({Key key, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(),
    );
  }
}
