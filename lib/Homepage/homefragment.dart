import 'dart:ffi';

import 'package:ecom/Cart/Cart.dart';
import 'package:ecom/Cart/cart1.dart';
import 'package:ecom/Homepage/BestOffers.dart';
import 'package:ecom/Homepage/Categorylist/categorylistdata.dart';
import 'package:ecom/Homepage/Categorylist/categorylistimport.dart';
import 'package:ecom/Homepage/Discovery/Discover.dart';
import 'package:ecom/Homepage/Discovery/Discoverdata.dart';
import 'package:ecom/Homepage/Discovery/discoverimport.dart';
import 'package:ecom/Homepage/Varieties.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Drawer.dart';
import './carousel.dart';
import 'Invite.dart';
import 'Categorylist/categorylist.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

class _HomefragmentState extends State<HomeFragment> {
  List values;
  String a, b, c;
  Discoverdata _discoverdata;
  bool _isloading = true;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _discoverrefresh();
  }

  _discoverrefresh() async {
    await Discoverimport.getUsers().then((value) {
      setState(() {
        _discoverdata = value;
        _isloading = false;
        print(_discoverdata.results[0].image);
      });
    });
  }

  var response;
  Future<void> _refresh() async {
    setState(() {
      _isloading = true;
      _discoverrefresh();
      // Discoverimport.getUsers();
      // Categorylistimport.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar1(context),
      key: _scaffoldKey,
      drawer: Drawer1(),
      body: LiquidPullToRefresh(
        onRefresh: () {
          return _refresh();
        },
        child: _isloading
            ? Center(
                child: CupertinoAlertDialog(
                title: Text(
                    "Please make sure you have an active internet connection"),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      _refresh();
                    },
                    child: Text("Retry"),
                  )
                ],
              ))
            : Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: SingleChildScrollView(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    _textsection(context),
                    SizedBox(height: 10),
                    Categorylist(),
                    SizedBox(height: 5),
                    _categoryheading(context, "Discover"),
                    // SpecialProducts(),
                    Discover(receiveddiscoverdata: _discoverdata),
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
                    Discover(receiveddiscoverdata: _discoverdata),
                  ]),
                ),
              ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  final cities = ["aa"];

  final recentCities = ["aa"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: transitionAnimation,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentCities : cities;
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.near_me),
              title: Text(cities[index]),
            ),
        itemCount: suggestionList.length);
  }
}

AppBar _appBar1(BuildContext context) {
  return AppBar(
    // backgroundColor: Colors.white,
    elevation: 0.0,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.black,
      ),
      onPressed: () {
        _scaffoldKey.currentState.openDrawer();
      },
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
            alignment: Alignment.centerRight,
            child: Center(
              child: Text(
                "Treg Mart",
                style: Theme.of(context).textTheme.headline3,
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 20),
              icon: Icon(
                EvaIcons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchBar());
              },
            ),
            IconButton(
              icon: Icon(
                EvaIcons.shoppingCartOutline,
                color: Colors.black,
              ),
              padding: EdgeInsets.only(left: 20),
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()),
                );
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _textsection(BuildContext context) {
  String a = "Anitesh";
  return Padding(
      padding: EdgeInsets.only(left: 7.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              a != null ? "Hola, Amigo" : "Hi, $a",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            "Explore TREG",
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(letterSpacing: 1),
          ),
          //Text("data"),
        ],
      ));
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
