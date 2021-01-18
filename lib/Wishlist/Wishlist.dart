import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:ecom/Wishlist/Wishlistapi.dart';
import 'package:ecom/Wishlist/Wishlistapiimport.dart';
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

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  Productdetails _productdetails;
  Wishlistapi _wishlistapi;
  List<String> _wishlistproductids = [];
  @override
  void initState() {
    super.initState();
    getwishlist();
  }

  getwishlist() async {
    await Wishlistapiimport.getwishlist().then((value) => setState(() {
          _wishlistapi = value;
        }));
     for (var i = 0; i < _wishlistapi.wishlist.length; i++) {
      _wishlistproductids.add(_wishlistapi.wishlist[i].productId.toString());
    }
    await Productdetailsimport.getProductdetails(_wishlistproductids)
        .then((value) => setState(() {
              _productdetails = value;
            }));
  }

  addtocart(String _product, _quantity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    Map data = {'product': _product, 'quantity1': _quantity};
    var jsonresponse;
    var response = await http.post(
        "https://infintymall.herokuapp.com/homepage/api/cart/",
        body: data,
        headers: {HttpHeaders.authorizationHeader: token});
    print(response.body);
    if (response.statusCode == 200) {
      jsonresponse = json.decode(response.body);
    }
    if (jsonresponse != null) {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => Cart()),
      //     (Route<dynamic> route) => false);
    } else {
      CupertinoDialogAction(
        child: Text("Please check your internet connection"),
      );
    }
    print(response.statusCode);
    print(jsonresponse);
  }

  postwishlist(String _productid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    Map data = {'product': _productid};
    var jsonresponse;
    var response = await http.post(
        "http://infintymall.herokuapp.com/homepage/api/wishlist",
        body: data,
        headers: {HttpHeaders.authorizationHeader: token});
    print(response.body);
    if (response.statusCode == 200) {
      jsonresponse = json.decode(response.body);
    } else {
      CupertinoDialogAction(
        child: Text("Please check your internet connection"),
      );
    }
    print(response.statusCode);
    print(jsonresponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // appBar: _appBar(context),
        body: SafeArea(
          child: _wishlistapi == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _wishlistapi.wishlist.length == 0
                  ? Container(
                      child: Center(
                        child: Text("Your wishlist is empty"),
                      ),
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
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: FadeInImage(
                                    imageErrorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {
                                      print('Error Handler');
                                      return Container(
                                          decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/drinks.jpg"),
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ), // set rounded corner radius
                                      ));
                                    },
                                    placeholder:
                                        AssetImage('assets/images/loading.gif'),
                                    image: NetworkImage(
                                        _productdetails.results[index].image),
                                    fit: BoxFit.cover,
                                    width: 50.0,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        _productdetails.results[index].image,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _productdetails
                                                  .results[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            SizedBox(height: 5.0),
                                            Text(
                                              _productdetails
                                                  .results[index].price
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
                                          onTap: () {
                                            setState(() {
                                              addtocartbutton() async {
                                                await addtocart(
                                                    _productdetails
                                                        .results[index].id
                                                        .toString(),
                                                    '1');
                                                await postwishlist(
                                                    _productdetails
                                                        .results[index].id
                                                        .toString());
                                                getwishlist();
                                              }

                                              addtocartbutton();
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 30.0,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3 -
                                                30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color:
                                                        Colors.orangeAccent)),
                                            child: Text(
                                              "Add to cart",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  .copyWith(
                                                      fontSize: 15.0,
                                                      color:
                                                          Colors.orangeAccent,
                                                      letterSpacing: 0.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              removefromwishlist() async {
                                                await postwishlist(
                                                    _productdetails
                                                        .results[index].id
                                                        .toString());
                                                getwishlist();
                                              }

                                              removefromwishlist();
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 30.0,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
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




