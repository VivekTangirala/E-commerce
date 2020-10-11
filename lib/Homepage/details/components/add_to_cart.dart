import 'dart:io';

import 'package:ecom/Cart/cart1.dart';
import 'package:ecom/Homepage/details/Product.dart';
import 'package:ecom/Homepage/details/components/cart_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AddToCart extends StatefulWidget {
  final productid,quantity;

  const AddToCart({Key key, this.productid, this.quantity}) : super(key: key);

  
  @override
  _AddToCartState createState() => _AddToCartState(productid,quantity);
}

class _AddToCartState extends State<AddToCart> {
  final  productid,quantity;

  _AddToCartState(this.productid, this.quantity);


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
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  color: Colors.orange,
                  onPressed: () {
                    addtocart('$productid', '$quantity');
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token =  sharedPreferences.getString('token');
    
    Map data = {'product': _product, 'quantity1': _quantity};
    var jsonresponse;
    var response = await http.post(
        "http://infintymall.herokuapp.com/homepage/api/cart/",
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
}
