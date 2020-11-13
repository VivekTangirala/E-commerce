import 'package:ecom/Cart/cart1.dart';
import 'package:ecom/Receipe/Details1.dart';
import 'package:ecom/Receipe/Directions.dart';
import 'package:ecom/Receipe/details.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> l1 = [
  "Pizza",
  "Burger",
  "Nutella milkshake",
  "Brownie",
  "Nutella milkshake",
  "Brownie"
];
List<String> l2 = [
  "\$10.50",
  "\$10.50",
  "\$10.50",
  "\$10.50",
  "\$10.50",
  "\$10.50"
];
List<String> images = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  "assets/images/some.jpg",
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
];

class RecipiCategorylistexpansion extends StatefulWidget {
  final index1;

  const RecipiCategorylistexpansion({Key key, this.index1}) : super(key: key);
  @override
  _RecipiCategorylistexpansionState createState() =>
      _RecipiCategorylistexpansionState(index1);
}

class _RecipiCategorylistexpansionState
    extends State<RecipiCategorylistexpansion> {
  final index;

  _RecipiCategorylistexpansionState(this.index);
  @override
  Widget build(BuildContext context) {
    // var _imageheight = MediaQuery.of(context).size.height / 4;
    var _imagewidth = MediaQuery.of(context).size.width / 2 - 50;

    return Scaffold(
      appBar: _appBar(context, index),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Column(
          children: [
            Container(
              child: GridView.builder(
                  itemCount: l1.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  // RecipeSteps(steps: l1,)
                                  Details1(),
                                  ));
                        }
                      },
                      child: Container(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: _imagewidth,
                              width: _imagewidth,
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  l1[index],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  l2[index],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),

                            // Divider()
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context, index) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: Hero(
      tag: 'categorylist$index',
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Popular",
            style: Theme.of(context).textTheme.headline3,
          )),
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
            MaterialPageRoute(builder: (context) => Cart()),
          );
        },
      ),
    ],
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
