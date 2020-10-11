import 'dart:convert';
import 'dart:io';

import 'package:ecom/Homepage/Discovery/Discoverdata.dart';
import 'package:http/http.dart' as http;
import 'package:ecom/Homepage/details/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_to_cart.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size * 1.3;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height / 1.2,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.22,
                  width: size.width,
                  child: Hero(
                    tag: "${product.id}",
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.2),
                  padding: EdgeInsets.only(
                    top: size.height * 0.005,
                    left: 20,
                    right: 20,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      // CounterWithFavBtn(),
                      ProductTitleWithImage(product: product),
                      AddToCart(
                        productid: 2,
                        quantity: 6,
                      ),
                      //ColorAndSize(product: product),
                      SizedBox(height: 20 / 3),
                      Description(product: product),
                      SizedBox(height: 20 / 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    static Future<Discoverdata> getUsers() async {
    try {
      final response = await http.get( "http://infintymall.herokuapp.com/homepage/api/product");
      if (response.statusCode == 200) {
        final Discoverdata discover = discoverdataFromJson(response.body);
        return discover;
      } else {
        print("error");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
