
import 'package:ecom/Login/login.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> l1 = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
];
List<String> l2 = [
  "Tomatoes",
  "Onions",
  "Burger",
];
List<String> l3 = [
  "10.5",
  "15.25",
  "50.0",
];

class Carthome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Carthomestate();
  }
}

class Carthomestate extends State<Carthome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 25.0),
            ListView.builder(
                itemCount: l1.length,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                l1[index],
                                height: 70.0,
                                width: 90.0,
                              ),
                              SizedBox(width: 15.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5.0),
                                    Text(
                                      l2[index],
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      l3[index],
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ])
                            ],
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Sub Total",
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  "15.50",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Discount",
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  "2.5",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  "12.25",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.orangeAccent),
                child: Text(
                  "Checkout",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white, letterSpacing: 1.0),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Colors.white,
    elevation: 0.0,
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        }),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
            alignment: Alignment.centerRight,
            child: Center(
              child: Text(
                "MyCart",
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
