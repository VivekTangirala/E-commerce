import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;

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

class CarouselPages extends StatefulWidget {
  @override
  _CarouselPagesState createState() => _CarouselPagesState();
}

class _CarouselPagesState extends State<CarouselPages> {
  List values;
  String a, b, c;

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  Future<List<Imaged>> fetchPost() async {
    final response = await http.get(
      'http://infintymall.herokuapp.com/homepage/api/carousel',
      headers: {
        HttpHeaders.authorizationHeader:
            "Token 	c1c6845868d8ce520aaa7b5078370f3ddce55e31"
      },
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      values = json.decode(response.body);
      try {
        final x = await http.get("${values[0]["image1"]}");
        if (x.statusCode == 200) {
          setState(() {
            a = "${values[0]["image1"]}";
            b = "${values[0]["image2"]}";
            c = "${values[0]["image3"]}";
          });
        }
      } on RangeError {
        print(response);
      }
      // print(values[0]["image1"]);
      //return values;

    } else {
      print(response);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        //margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        height: 175.0,
        
        //width: 3000,
        //width: 300,
        child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Carousel(
            boxFit: BoxFit.cover,
            autoplay: true,
            animationCurve: Curves.easeOutSine,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 6.0,
            dotIncreasedColor: Color(0xFFFF335C),
            dotBgColor: Colors.transparent,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            showIndicator: true,
            indicatorBgPadding: 7.0,
            images: [
              a != null
                  ? CachedNetworkImage(
                      imageUrl: a,
                      placeholder: (context, url) =>
                          new Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/earphones.jpg',
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
              b != null
                  ? CachedNetworkImage(
                      imageUrl: b,
                      placeholder: (context, url) =>
                          new Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/earphones.jpg'),
                    )
                  : Center(child: CircularProgressIndicator()),
              c != null
                  ? CachedNetworkImage(
                      imageUrl: c,
                      placeholder: (context, url) =>
                          new Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/earphones.jpg'),
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          );
        }));
  }
}
