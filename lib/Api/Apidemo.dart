import 'package:flutter/material.dart';


class Api extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("API"),
        ),
        body: ListView.builder(
            itemExtent: 50.0,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Data"),
              );
            }));
  }
}
