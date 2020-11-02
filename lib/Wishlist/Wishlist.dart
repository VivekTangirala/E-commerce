import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:ecom/Api/Wishlistapi/Wishlistapi.dart';
import 'package:ecom/Api/Wishlistapi/Wishlistapiimport.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
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

var _qty = new List.generate(l1.length, (index) => 1);

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  Productdetails _productdetails;
  Wishlistapi _wishlistapi;
  List<String> _wishlistproductids = [];
  bool _isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishlist();
    productdetails();
  }

  wishlist() async {
    await Wishlistapiimport.getwishlist().then((value) => setState(() {
          _wishlistapi = value;
          _isloading = false;
        }));
    for (var i = 0; i < _wishlistapi.wishlist.length; i++) {
      _wishlistproductids.add(_wishlistapi.wishlist[i].productId.toString());
    }
    Productdetailsimport.getProductdetails(_wishlistproductids)
        .then((value) => setState(() {
              _productdetails = value;
              _isloading = false;
            }));
  }

  productdetails() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: SafeArea(
          child: _productdetails == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: _wishlistapi.wishlist.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    _productdetails.results[index].image,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _productdetails.results[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          _productdetails.results[index].price
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     IconButton(
                                    //       icon: Icon(
                                    //         Icons.add_circle,
                                    //         color: Colors.orangeAccent,
                                    //       ),
                                    //       onPressed: () {
                                    //         setState(() {
                                    //           _qty[index] = _qty[index] + 1;
                                    //         });
                                    //       },
                                    //     ),
                                    //     Text(
                                    //       _qty[index].toString().padLeft(1, "0"),
                                    //     ),
                                    //     IconButton(
                                    //       icon: Icon(
                                    //         Icons.remove_circle,
                                    //         color: Colors.orangeAccent,
                                    //       ),
                                    //       onPressed: () {
                                    //         setState(() {
                                    //           if (_qty[index] > 1) {
                                    //             _qty[index] = _qty[index] - 1;
                                    //           }
                                    //         });
                                    //       },
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 30.0,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: Colors.orangeAccent)),
                                        child: Text(
                                          "Add to cart",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              .copyWith(
                                                  fontSize: 15.0,
                                                  color: Colors.orangeAccent,
                                                  letterSpacing: 0.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 30.0,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: Colors.redAccent)),
                                        child: Text(
                                          "Remove",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              .copyWith(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent,
                                                  letterSpacing: 0.0),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}

/////////////////////////////////////////////////////////

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
                "Wishlist",
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
              onPressed: () async {},
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
