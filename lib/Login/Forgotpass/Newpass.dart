import 'package:flutter/material.dart';

import '../../bottom_nav.dart';

class Newpass extends StatefulWidget {
  @override
  _NewpassState createState() => _NewpassState();
}

class _NewpassState extends State<Newpass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[headerSection(), textSection(), buttonSection()],
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Container(
            child: Center(
          child: Text(
            "Change Password",
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.orangeAccent),
          ),
        )));
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30.0),
          TextFormField(
            //controller: passwordController,
            cursorColor: Colors.black,
            obscureText: true,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.orangeAccent),
              hintText: "Enter new Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            //controller: password2Controller,
            cursorColor: Colors.black,
            obscureText: true,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.orangeAccent),
              hintText: "Re-enter Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
              (Route<dynamic> route) => false);
        },
        elevation: 0.0,
        color: Colors.orangeAccent,
        child: Text("Confirm",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
