import 'dart:io';

import 'package:ecom/components/logInPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

int numOfItems = 1;
var _statuscode;

class AddToCart extends StatefulWidget {
  final productid;

  const AddToCart({Key key, this.productid}) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState(productid);
}

class _AddToCartState extends State<AddToCart> {
  final productid;
  String token;
  _AddToCartState(this.productid);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: <Widget>[
            CartCounter(),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                // ignore: deprecated_member_use
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  color: Colors.orange,
                  onPressed: () async {
                    if (token == null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                                title: "Login",
                                descriptions:
                                    "SignIn to add products into the cart",
                                image: "assets/icons/Error.svg");
                          });
                    } else {
                      await addtocart('$productid', '$numOfItems');

                      if (_statuscode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Added to cart"),
                            duration: Duration(seconds: 5),
                            action: SnackBarAction(
                              label: "Done",
                              onPressed: () {},
                            ),
                          ),
                        );
                      } else if (_statuscode == 401) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialogBox(
                                  title: "Login",
                                  descriptions:
                                      "SignIn to add products into the cart",
                                  image: "assets/icons/Error.svg");
                            });
                      }
                    }
                  },
                  child: Text(
                    "Add to Cart".toUpperCase(),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
          headers: {HttpHeaders.authorizationHeader: token});
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

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
