import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';

class Invite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(110),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(color: Colors.orangeAccent,borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Invite a friend and get rewards"),
            Card(
                color: Colors.orange,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("INVITE"),
                ))
          ]),
    );
  }
}
