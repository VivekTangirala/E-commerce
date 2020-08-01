import 'package:flutter/material.dart';

class _Appbar extends StatefulWidget {
  @override
  _Appbarstate createState()=>_Appbarstate();
}
class _Appbarstate extends State<_Appbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:50.0,
      child:Row(children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Treg Mart",
              style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white),
            ),
          ),
      ],),
    );
  }
}