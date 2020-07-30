import 'package:ecom/Homepage/just_for_you.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/Login/login.dart';
import './carousel.dart';
import './category.dart';
import 'package:ecom/placeholder_widget.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomefragmentState createState() => _HomefragmentState();
}

class _HomefragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Color(0xFFf83600),
          // leading: IconButton(
          //   icon: Icon(EvaIcons.menu,color:Colors.black),
          //   onPressed: () {},
          // ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Treg Mart",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          actions: <Widget>[
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
        body: Container(
          child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            CarouselPages(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.all(16),
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
                margin: EdgeInsets.all(16),
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
