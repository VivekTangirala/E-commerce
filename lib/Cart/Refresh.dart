import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
class Refresh extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<Refresh> {
  var list;
  var random;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      list = List.generate(random.nextInt(10), (i) => "Item $i");
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Pull to refresh"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: Container(
          child: ListView.builder(
            itemCount: list?.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(list[i]),
            ),
          ),
        ),
        // CarouselPages(),

        onRefresh: refreshList,
      ),
    );
  }
}

class Imaged {
  String image1;
  String image2;
  String image3;

  Imaged({this.image1, this.image2, this.image3});

  Imaged.fromJson(Map<String, dynamic> json) {
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
  }
}

class CarouselPages1 extends StatefulWidget {
  @override
  _CarouselPagesState createState() => _CarouselPagesState();
}

class _CarouselPagesState extends State<CarouselPages1> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List values;
  String a, b, c;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Refresh"),
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
