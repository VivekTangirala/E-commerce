import 'package:ecom/Homepage/just_for_you.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/Login/login.dart';
import './carousel.dart';
import './category.dart';
import 'package:ecom/placeholder_widget.dart';
import '_appbar.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeFragment extends StatefulWidget {
  @override
  _HomefragmentState createState() => _HomefragmentState();
}

class _HomefragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Account"),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5.0),
              ),
            )
          ],
        )),
        body: Container(
          child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(
              height: 25.0,
            ),
            _AppBar(),
            _Textsection(context),
            CarouselPages(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical:10.0,horizontal:15.0),
                child: Text(
                  "Just 4 U",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            SpecialProducts(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15.0,top: 10.0,bottom: 10.0),
                child: Text(
                  "Category",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Category(),
            Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                height: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/images/drinks.jpg',
                        )),
                    borderRadius: BorderRadius.all(Radius.circular(25)))),
          ])),
        ));
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

class _AppBar extends StatefulWidget {
  @override
  _AppBarstate createState() => _AppBarstate();
}

class _AppBarstate extends State<_AppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Treg Mart",
                  style: Theme.of(context).textTheme.headline3,
                ),
              )),
          Row(
            children: <Widget>[
              IconButton(
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
                padding: EdgeInsets.only(left: 10, right: 15),
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _Textsection(BuildContext context) {
  return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Hi , VIVEK",style: Theme.of(context).textTheme.bodyText1,),
          ),
          Text("Let's Explore",style: Theme.of(context).textTheme.headline3,),
          //Text("data"),
        ],
      ));
}