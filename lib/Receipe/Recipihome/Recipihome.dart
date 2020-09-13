import 'package:ecom/Homepage/Drawer.dart';
import 'package:ecom/Homepage/homefragment.dart';
import 'package:ecom/Login/login.dart';
import 'package:ecom/Receipe/Recipihome/Alltimefav.dart';
import 'package:ecom/Receipe/Recipihome/Madewithfew.dart';
import 'package:ecom/Receipe/Recipihome/Suggested.dart';
import 'package:ecom/Receipe/categorylistrecipe.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/data.dart';
import '../details.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Recipihome extends StatefulWidget {
  @override
  _RecipihomeState createState() => _RecipihomeState();
}

class _RecipihomeState extends State<Recipihome>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer1(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recipe",
                style: Theme.of(context).textTheme.headline3,
              )),
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
        body: ListView(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            children: <Widget>[
              textsection("Go with categories"),
              SizedBox(height: 15.0),
              Categorylistrecipe(),
              SizedBox(height: 20.0),
              textsection("Made with few ingridents"),
              MadewithfewIngridients(),
              SizedBox(height: 15.0),
              textsection("Suggested"),
              Suggested(),
              SizedBox(height: 15.0),
              textsection("All time favourite"),
              Alltimefav(),
            ]));
  }

  Widget textsection(String str) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(
        str,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}