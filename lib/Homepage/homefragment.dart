import 'package:ecom/Cart/Cart.dart';
import 'package:ecom/Homepage/just_for_you.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/Login/login.dart';
import 'Drawer.dart';
import './carousel.dart';
import './category.dart';
import 'package:ecom/placeholder_widget.dart';

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
        appBar: _appBar(context),
        drawer: Drawer1(),
        body: Container(
          margin: EdgeInsets.only(left: 8),
          child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            _textsection(context),
            SizedBox(height: 10),
            Categorylist(),
            SizedBox(height: 10),
            CarouselPages(),
            SizedBox(height: 10),
            _categoryheading(context, "Just 4 U"),
            SpecialProducts(),
            SizedBox(height: 15),
            _categoryheading(context, "Category"),
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
            "Let's Explore",
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(letterSpacing: 1),
          ),
          //Text("data"),
        ],
      ));
}

// child: Column(
//   children: <Widget>[
//     _ingredients[index],
//     // SizedBox(
//     //     height: 5.0,
//     //     width: 9.0,
//     //     child: DecoratedBox(
//     //         decoration: BoxDecoration(
//     //             color: Colors.orangeAccent,
//     //             borderRadius: BorderRadius.circular(5.0))))
//   ],
// ),

// Widget _categoryList() {
//   return SizedBox(
//     height: 50,
//     width: double.infinity,
//     child: ListView.builder(
//       itemCount: ingredients.length,
//       shrinkWrap: true,
//       scrollDirection: Axis.horizontal,
//       physics: BouncingScrollPhysics(),
//       itemBuilder: (BuildContext context, int index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: () {},
//             child: Chip(
//               backgroundColor: _chipcolor[index],
//               label: _ingredients[index],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }

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

List<Color> _chipcolor = [
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
];

List<Text> _ingredients = [
  Text("Fruits & vegetables",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)),
  Text("Snacks",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Staples",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Beaverages",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Bakery & dairy",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Personal care",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
];

class Categorylist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _categoryliststate();
  }
}

class _categoryliststate extends State<Categorylist> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        itemCount: _ingredients.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _chipcolor[index] = Colors.white;
                  
                });
              },
              child: Chip(
                backgroundColor: _chipcolor[index],
                label: _ingredients[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
