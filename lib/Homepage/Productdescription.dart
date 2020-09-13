import 'package:ecom/Cart/Cart.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';

class Productsdescription extends StatefulWidget {
  Productsdescription();
  @override
  _ProductsdescriptionState createState() => _ProductsdescriptionState();
}

class _ProductsdescriptionState extends State<Productsdescription> {
  _ProductsdescriptionState();

  @override
  Widget build(BuildContext context) {
    var _weight = 10;
    var _quantity = 1;
    bool _isLoading = false;
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Container(
                  height: 200.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset("assets/images/tomato.png"),
                  )),
              SizedBox(
                height: 15.0,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Tomato",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )),
              Divider(
                height: 20.0,
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("RS 25"),
                  DottedBorder(
                    color: Colors.orangeAccent,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isLoading = true;
                                  _weight = _weight - 1;
                                  _isLoading = false;
                                  print(_weight);
                                });
                              },
                              child: Text("-")),
                        ),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text("$_weight Kg"),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _weight = _weight + 1;
                                });
                              },
                              child: Text("+")),
                        ),
                      ],
                    ),
                  ),
                  DottedBorder(
                    color: Colors.orangeAccent,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _quantity = _quantity - 1;
                                });
                              },
                              child: Text("-")),
                        ),
                        Text("$_quantity QTY"),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () {
                                if (mounted == true) {
                                  setState(() {
                                    _quantity = _quantity + 1;
                                  });
                                }
                              },
                              child: Text("+")),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20.0,
                thickness: 1.0,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.orangeAccent),
                    ),
                  )),
              SizedBox(height: 10.0),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Some thing about the respective fruit",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 15.0),
                    ),
                  )),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.orangeAccent)),
                    child: Text(
                      "Add to cart",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.orangeAccent, letterSpacing: 1.0),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: MediaQuery.of(context).size.width / 2 - 20,
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
                ],
              )
            ],
          )),
    );
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
                  "Vegetables",
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
