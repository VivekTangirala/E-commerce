import 'dart:async';
import 'package:ecom/Login/login.dart';
import 'package:ecom/Orders/Orders.dart';
import 'package:ecom/Profile/main_profile.dart';
import 'package:ecom/Wishlist/Wishlist.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> l1 = [
  "Profile",
  "Orders",
  "Payents",
  "Wishlist",
  "My Recipies"
];
final List<Icon> i1 = [
  Icon(
    Icons.person,
    color: Colors.deepOrange,
    size: 40.0,
  ),
  Icon(
    Icons.menu,
    color: Colors.deepOrange,
    size: 40.0,
  ),
  Icon(
    Icons.credit_card,
    color: Colors.deepOrange,
    size: 40.0,
  ),
  Icon(
    MdiIcons.heart,
    color: Colors.deepOrange,
    size: 40.0,
  ),
  Icon(
    MdiIcons.chefHat,
    color: Colors.deepOrange,
    size: 40.0,
  ),
];
List<Color> c1 = [
  Colors.white10,
  Colors.white10,
  Colors.white10,
  Colors.white10,
  Colors.white10,
];

class Drawer1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Drawerstate();
  }
}

class _Drawerstate extends State<Drawer1> {
  SharedPreferences sharedPreferences;
  String name;
  void initState() {
    super.initState();
    checklogin();
  }

  Future checklogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('token');
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              height: 75.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Name",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        "Phone no",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return new Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: InkWell(
                  onTap: () {
                    if (index == 0) {
                      setState(() {
                        c1[index] = Colors.orangeAccent;
                      });

                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileFirst(),
                        ),
                      );
                      Timer(Duration(milliseconds: 100), () {
                        setState(() {
                          c1[index] = Colors.white10;
                        });
                      });
                    }
                   if (index == 1) {
                      setState(() {
                        c1[index] = Colors.orangeAccent;
                      });

                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Orders(),
                        ),
                      );
                      Timer(Duration(milliseconds: 100), () {
                        setState(() {
                          c1[index] = Colors.white10;
                        });
                      });
                    }
                     if (index == 3) {
                      setState(() {
                        c1[index] = Colors.orangeAccent;
                      });

                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Wishlist(),
                        ),
                      );
                      Timer(Duration(milliseconds: 100), () {
                        setState(() {
                          c1[index] = Colors.white10;
                        });
                      });
                    }
                  },
                  child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        color: c1[index],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  i1[index],
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    l1[index],
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.deepOrange,
                              ),
                            ]),
                      )),
                ));
          },
        ),
        SizedBox(height: 15.0),
        InkWell(
          onTap: name == null
              ? () {
                  sharedPreferences.clear();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                }
              : null,
          child: Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            alignment: Alignment.center,
            height: 50.0,
            //width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.deepOrange),
            child: Text(
              name == null ? "Sign out" : "Sign In",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.white, letterSpacing: 1.0),
            ),
          ),
        ),
      ],
    ));
  }
}
