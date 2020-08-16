import 'package:ecom/Cart/Cart.dart';
import 'package:ecom/Homepage/BestOffers.dart';
import 'package:ecom/Homepage/Discover.dart';
import 'package:ecom/Homepage/Varieties.dart';
import 'package:ecom/Homepage/just_for_you.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/Login/login.dart';
import 'Drawer.dart';
import './carousel.dart';
import './category.dart';
import 'package:ecom/placeholder_widget.dart';

import 'Invite.dart';
import 'categorylist.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeFragment extends StatefulWidget {
  @override
  _HomefragmentState createState() => _HomefragmentState();
}

class _HomefragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      //appBar: _appBar(context),
      drawer: Drawer1(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              actions: [
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
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  onPressed: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Carthome()),
                    );
                  },
                ),
              ],
              elevation: 0.0,
              backgroundColor: Colors.white,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                // title: Row(

                background:
                    // Image.asset("assets/images/tomato.png", fit: BoxFit.cover),
                    CarouselPages(),
              ),
            ),
          ];
        },
        body: Container(
          margin: EdgeInsets.only(left: 8,right: 8),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              _textsection(context),
              SizedBox(height: 10),
              Categorylist(),
              SizedBox(height: 10),
              _categoryheading(context, "Discover"),
              // SpecialProducts(),
              Discover(),
              _categoryheading(context, "Best Offers"),
              Bestoffers(),
              //Category(),
              _categoryheading(context, "Varieties"),

              Varieties(),
              SizedBox(height: 15.0),
              Invite(),
              _categoryheading(context, "Great Deals"),
              Discover(),
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

class SilverApp extends StatefulWidget {
  @override
  _SilverAppState createState() => _SilverAppState();
}

class _SilverAppState extends State<SilverApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  //_scaffoldKey.currentState.openDrawer();
                },
              ),
              actions: [
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
                      MaterialPageRoute(builder: (context) => Carthome()),
                    );
                  },
                ),
              ],
              elevation: 0.0,
              backgroundColor: Colors.white,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                // title: Row(

                background: CarouselPages(),
              ),
            ),
          ];
        },
        body: Center(
          child: Text("sample"),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => Carthome()),
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

// class Categorylist extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _categoryliststate();
//   }
// }

// class _categoryliststate extends State<Categorylist> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: double.infinity,
//       child: ListView.builder(
//         itemCount: _ingredients.length,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   _chipcolor[index] = Colors.white;

//                 });
//               },
//               child: Chip(
//                 backgroundColor: _chipcolor[index],
//                 label: _ingredients[index],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
