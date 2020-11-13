import 'package:ecom/Api/Categorydetailsapi/Categorydetailsapi.dart';
import 'package:ecom/Api/Categorydetailsapi/Categorydetailsimport.dart';
import 'package:ecom/Cart/cart1.dart';
import 'package:ecom/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

List<String> list = ["Pineapple", "Cherry", "Orange", "Apple"];
List<String> list1 = ["25", "50", "45", "55"];
final List<String> images = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  'assets/images/some.jpg',
];

class Categoryitems extends StatefulWidget {
  final String string;

  const Categoryitems({Key key, this.string}) : super(key: key);
  @override
  Categoryitemsstate createState() => Categoryitemsstate(string);
}

class Categoryitemsstate extends State<Categoryitems> {
  final String _string;
  Categorydetails _categorydetails;

  Categoryitemsstate(this._string);
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategorydetails1();
  }

  getcategorydetails1() async {
    await Categorydetailsimport.getcategorydetails(_string)
        .then((value) => setState(() {
              _categorydetails = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    var width = screenSize(context).width;
    var height = screenSize(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: _categorydetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    //padding: EdgeInsets.only(right: 15.0),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 25.0),
                    itemCount: _categorydetails.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Column(children: [
                          SizedBox(
                            height: height / 5.8,
                            width: width / 2.5,
                            child: Container(
                              //alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // border: Border.all(
                                //     color: Colors.black12, // set border color
                                //     width: 0.6), // set border width
                                borderRadius: BorderRadius.all(Radius.circular(
                                    5.0)), // set rounded corner radius
                              ),
                              child: Image.network(
                                  _categorydetails.results[index].image),
                            ),
                          ),
                          // SizedBox(height: 0.0),
                          Text(
                            _categorydetails.results[index].name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          // Text(
                          //   list1[index],
                          //   style: Theme.of(context).textTheme.caption,
                          // )
                        ]),
                        onTap: () {},
                      );
                    },
                  ),
                ],
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
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
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
