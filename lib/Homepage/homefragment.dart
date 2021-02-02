import 'package:ecom/Cart/cart.dart';
import 'package:ecom/Homepage/BestOffers.dart';
import 'package:ecom/Homepage/Brand/Brand.dart';
import 'package:ecom/Homepage/Cashback.dart';
import 'package:ecom/Homepage/Invite.dart';
import 'package:ecom/Homepage/categories.dart';
import 'package:ecom/components/screensize.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        appBar: _appBar(context),
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
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        // _textsection(context),

                        // SizedBox(height: 10),
                        SizedBox(height: getProportionateScreenHeight(15.0)),

                        _searchBar(context),
                        SizedBox(height: getProportionateScreenHeight(15.0)),

                        Cashback(),
                        SizedBox(height: getProportionateScreenHeight(10.0)),

                        // _categoryheading(context, "Categories"),
                        //  SizedBox(height: getProportionateScreenHeight(10.0)),

                        CategoriesNew() ,
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

Widget _searchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.all(
                  Radius.circular(38.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                     top: 0, bottom: 0),
                child: TextField(
                  onChanged: (String txt) {},
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.only(left:16),
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(38.0),
                        ),
                        borderSide: new BorderSide(
                          color: Colors.teal,
                        )),
                    //  border: InputBorder.none,
                    hintText: 'Search...',
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: getProportionateScreenHeight(40),
          width: getProportionateScreenWidth(40),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 8.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Icon(Icons.search, size: 25, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
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
                EvaIcons.heartOutline,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart1()),
                );
              },
            ),
          ],
        ),
      ],
    ),
  );
}
