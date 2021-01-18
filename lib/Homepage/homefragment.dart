import 'package:ecom/Homepage/BestOffers.dart';
import 'package:ecom/Homepage/Brand/Brand.dart';
import 'package:ecom/Homepage/Invite.dart';
import 'package:ecom/components/appBar.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'Categorylist/Category.dart';
import 'Discovery/Discover.dart';
import 'Drawer.dart';
import 'Varieties.dart';

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

class HomeFragment extends StatefulWidget {
  @override
  _HomefragmentState createState() => _HomefragmentState();
}

class _HomefragmentState extends State<HomeFragment>
    with AutomaticKeepAliveClientMixin {
  // bool _firstload = false;
  List values;
  String a, b, c;
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  var response;
  Future<void> _refresh() async {
    setState(() {
      _isloading = false;
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, _scaffoldKey),
        key: _scaffoldKey,
        drawer: Drawer1(),
        body: SafeArea(
          child: LiquidPullToRefresh(
            onRefresh: () {
              return _refresh();
            },
            child: _isloading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // _textsection(context),
                            // SizedBox(height: 10),
                            _categoryheading(context, "Categories"),

                            Category(),
                            SizedBox(height: 5),

                            _categoryheading(context, "Discover"),
                            // SpecialProducts(),
                            Discover(),
                            SizedBox(height: 20.0),

                            _categoryheading(context, "Best Offers"),
                            Bestoffers(),
                            //Category(),
                            SizedBox(height: 20.0),

                            _categoryheading(context, "Varieties"),

                            Varieties(),
                            SizedBox(height: 30.0),
                            Invite(),
                            SizedBox(height: 30.0),
                            _categoryheading(context, "Great Deals"),
                            Discover(),
                            SizedBox(height: 20.0),
                            _categoryheading(context, "Shop by brand"),
                            Brand(),
                          ]),
                    ),
                  ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _categoryheading(BuildContext context, String str) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(left: 7.0, top: 10.0, bottom: 10.0),
      child: Text(
        "$str",
        style: Theme.of(context).textTheme.headline3,
      ),
    ),
  );
}
