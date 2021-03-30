import 'dart:convert';
import 'dart:io';
import 'package:ecom/Cart/Cartapi.dart';
import 'package:ecom/Cart/cart.dart';
import 'package:ecom/components/screensize.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Wishlistapi _wishlistapi;
  bool _firstload = false;
  @override
  void initState() {
    super.initState();
    getwishlist();
  }

  getwishlist() async {
    await Wishlistapiimport.getwishlist().then((value) => setState(() {
          _wishlistapi = value;
        }));
    _firstload = true;
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
        "https://infintymall.herokuapp.com/homepage/api/wishlist",
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
      appBar: _appBar(context),
      body: SafeArea(
        child: _firstload == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _wishlistapi.wishList.length == 0
                ? Center(
                    child: Text("Your wishlist is empty,let's go shopping..."),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 8.0),
                    //width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: _wishlistapi.wishList.length,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          //  margin: EdgeInsets.all(getProportionateScreenWidth(5.0)),
                          // height: MediaQuery.of(context).size.height / 6,
                          // width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(10.0),
                                  bottom: getProportionateScreenHeight(10.0),
                                  left: getProportionateScreenHeight(5.0),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child:
                                    //  CircularProgressIndicator(),
                                    Container(
                                      height: getProportionateScreenHeight(
                                              80.0),
                                          width: getProportionateScreenWidth(
                                              100.0),
                                  child: FadeInImage(
                                    imageErrorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {
                                      return Container(
                                          height: getProportionateScreenHeight(
                                              80.0),
                                          width: getProportionateScreenWidth(
                                              100.0),
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
                                        AssetImage("assets/images/loading.gif"),
                                    image: NetworkImage(
                                      _wishlistapi
                                          .wishList[index].product.image,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _wishlistapi
                                            .wishList[index].product.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        _wishlistapi
                                            .wishList[index].product.price
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() async {
                                        addtocartbutton() async {
                                          await addtocart(
                                              _wishlistapi
                                                  .wishList[index].product.id
                                                  .toString(),
                                              '1');
                                          await postwishlist(
                                            _wishlistapi
                                                .wishList[index].product.id
                                                .toString(),
                                          );
                                          await getwishlist();
                                        }

                                        await addtocartbutton();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height:
                                          getProportionateScreenHeight(32.0),
                                      width: getProportionateScreenWidth(100.0),
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
                                    height: getProportionateScreenHeight(18.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        removefromwishlist() async {
                                          await postwishlist(
                                            _wishlistapi
                                                .wishList[index].product.id
                                                .toString(),
                                          );
                                          getwishlist();
                                        }

                                        removefromwishlist();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height:
                                          getProportionateScreenHeight(32.0),
                                      width: getProportionateScreenWidth(100.0),
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
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
      ),
      title: Text("Wishlist",
          style: GoogleFonts.lato(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          )),
      centerTitle: true,
      backgroundColor: Colors.grey.shade100,
      actions: [
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return Cart1();
              }));
            },
            color: Colors.greenAccent,
            child: Text(
              "Cart",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
