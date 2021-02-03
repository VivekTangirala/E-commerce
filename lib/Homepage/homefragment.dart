import 'package:ecom/Homepage/BestOffers.dart';
import 'package:ecom/Homepage/Brand/Brand.dart';
import 'package:ecom/Homepage/Cashback.dart';
import 'package:ecom/Homepage/Invite.dart';
import 'package:ecom/components/appBar.dart';
import 'package:ecom/components/screensize.dart';
import 'package:ecom/components/searchBar.dart';
import 'package:flutter/cupertino.dart';
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

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
  TextEditingController _textEditingController;
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context,scaffoldKey),
        key: scaffoldKey,
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
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        // _textsection(context),

                        // SizedBox(height: 10),
                        SizedBox(height: getProportionateScreenHeight(15.0)),

                        searchBar(context),
                        SizedBox(height: getProportionateScreenHeight(15.0)),

                        Cashback(),
                        SizedBox(height: getProportionateScreenHeight(10.0)),

                        // _categoryheading(context, "Categories"),
                        //  SizedBox(height: getProportionateScreenHeight(10.0)),

                        Category(),
                        //SizedBox(height: getProportionateScreenHeight(5.0)),
                        SizedBox(height: getProportionateScreenHeight(10.0)),

                        _categoryheading(context, "Discover"),
                        // SpecialProducts(),
                        Discover(),
                        // SizedBox(height: getProportionateScreenHeight(5.0)),

                        _categoryheading(context, "Best Offers"),
                        Bestoffers(),
                        //Category(),
                        SizedBox(height: getProportionateScreenHeight(15.0)),

                        _categoryheading(context, "Varieties"),
                        SizedBox(height: getProportionateScreenHeight(10.0)),
                        Varieties(),
                        SizedBox(height: getProportionateScreenHeight(10.0)),
                        Invite(),
                        SizedBox(height: getProportionateScreenHeight(20.0)),
                        _categoryheading(context, "Great Deals"),
                        Discover(),
                        SizedBox(height: getProportionateScreenHeight(20.0)),
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



