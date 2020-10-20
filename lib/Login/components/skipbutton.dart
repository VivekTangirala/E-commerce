import 'package:ecom/bottom_nav.dart';
import 'package:flutter/material.dart';

class SkipSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          //await setSkip();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
              (Route<dynamic> route) => false);
        },
        child: Text(
          "Skip Login",
          style: TextStyle(
               color: Colors.black),
        ),
      ),
    );
  }
}
