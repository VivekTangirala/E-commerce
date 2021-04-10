import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecom/Cart/cart.dart';
import 'package:ecom/Homepage/categoryitems/Categorydetailsapi.dart';
import 'package:ecom/Homepage/categoryitems/Categorydetailsimport.dart';
import 'package:ecom/Wishlist/Wishlist.dart';
import 'package:ecom/components/appBar.dart';
import 'package:ecom/components/logInPopup.dart';
import 'package:ecom/components/screensize.dart';
import 'package:ecom/productDetails/details_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categoryitems extends StatefulWidget {
  final String string;

  const Categoryitems({Key key, this.string}) : super(key: key);
  @override
  Categoryitemsstate createState() => Categoryitemsstate(string);
}

class Categoryitemsstate extends State<Categoryitems> {
  final String _string;
  List<Categorydetails> _categorydetails;

  Categoryitemsstate(this._string);

  List<bool> _inwhishlist = List<bool>.generate(10, (index) => false);

  String _token;

  var _statuscode;
  @override
  void initState() {
    super.initState();
    getcategorydetails1();
    getToken();
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString('token');
  }

  getcategorydetails1() async {
    await Categorydetailsimport.getcategorydetails(_string)
        .then((value) => setState(() {
              _categorydetails = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      backgroundColor: Colors.white,
      // appBar: appBar(context,),
      body: _categorydetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8.0),
                        vertical: getProportionateScreenHeight(5.0)),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _categorydetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FadeInImage(
                                    imageErrorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {
                                      return Container(
                                        padding: EdgeInsets.all(5.0),
                                        height:
                                            getProportionateScreenHeight(100.0),
                                        width:
                                            getProportionateScreenWidth(100.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              "assets/images/drinks.jpg",
                                            ),
                                          ),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ), // set rounded corner radius
                                        ),
                                      );
                                    },
                                    placeholder:
                                        AssetImage('assets/images/loading.gif'),
                                    image: NetworkImage(
                                      _categorydetails[index].image,
                                    ),
                                    fit: BoxFit.fill,
                                    width: getProportionateScreenWidth(100.0),
                                    height: getProportionateScreenHeight(100),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(5.0),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,

                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(_categorydetails[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2),
                                            Text(
                                                "Price:- " +
                                                    _categorydetails[index]
                                                        .offerPrice
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13)),
                                            Text(
                                              "Discount:- " +
                                                  _categorydetails[index]
                                                      .discountPercentage
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13),
                                            ),
                                            Text(
                                                "You save- " +
                                                    (_categorydetails[index]
                                                                .price -
                                                            _categorydetails[
                                                                    index]
                                                                .offerPrice)
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13)),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      15.0),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  _inwhishlist[index] == false
                                                      ? EvaIcons.heartOutline
                                                      : EvaIcons.heart,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _inwhishlist[index] =
                                                        !_inwhishlist[index];
                                                  });
                                                }),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        4.0),
                                              ),
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0)),
                                                onPressed: () async {
                                                  if (_token == null) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CustomDialogBox(
                                                              title: "Login",
                                                              descriptions:
                                                                  "SignIn to add products into the cart",
                                                              image:
                                                                  "assets/icons/Error.svg");
                                                        });
                                                  } else {
                                                    await addtocart('2', '1');

                                                    if (_statuscode == 200) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: const Text(
                                                              "Added to cart"),
                                                          duration: Duration(
                                                              seconds: 5),
                                                          action:
                                                              SnackBarAction(
                                                            label: "Done",
                                                            onPressed: () {},
                                                          ),
                                                        ),
                                                      );
                                                    } else if (_statuscode ==
                                                        401) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CustomDialogBox(
                                                                title: "Login",
                                                                descriptions:
                                                                    "SignIn to add products into the cart",
                                                                image:
                                                                    "assets/icons/Error.svg");
                                                          });
                                                    }
                                                  }
                                                },
                                                color: Colors.greenAccent,
                                                child: Text(
                                                  "Add to cart",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return DetailsScreen(
                              productid: 2,
                            );
                          }));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Center(
        child: Text(
          _string,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.only(left: 20),
          icon: Icon(
            EvaIcons.heartOutline,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Wishlist();
                },
              ),
            );
            //  showSearch(context: context, delegate: SearchBar());
          },
        ),
        IconButton(
          icon: Icon(
            EvaIcons.shoppingCartOutline,
            color: Colors.black,
          ),
          padding: EdgeInsets.only(left: 20, right: 16),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart1()),
            );
          },
        ),
      ],
    );
  }

  addtocart(String _product, _quantity) async {
    Map data = {'product': _product, 'quantity1': _quantity};
    var jsonresponse;
    var response;
    try {
      response = await http.post(
          "https://infintymall.herokuapp.com/homepage/api/cart",
          body: data,
          headers: {HttpHeaders.authorizationHeader: _token});
    } on SocketException {
      SnackBar(
        content: const Text("Check your internet connection"),
        duration: Duration(seconds: 5),
        // action: SnackBarAction(
        //   label: "Retry",
        //   onPressed: () {},
        // ),
      );
    }
    _statuscode = response.statusCode;
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
  }
}
