import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_to_cart.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatefulWidget {
  final productid;

  const Body({Key key, this.productid}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(productid);
}

class _BodyState extends State<Body> {
  final _productid;

  _BodyState(this._productid);

  Productdetails _productdetails;
  List<String> l = [];

  @override
  void initState() {
    super.initState();

    refreshproductdetails();
  }

  refreshproductdetails() async {
    l.add(_productid.toString());
    Productdetailsimport.getProductdetails(l).then((value) => setState(() {
          _productdetails = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size * 1.3;
    return _productdetails != null
        ? SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height / 1.2,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.22,
                        width: size.width,
                        child: Image.network(
                          _productdetails.results[0].image,
                          fit: BoxFit.fill,
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
                            ProductTitleWithImage(
                              productdetails: _productdetails,
                            ),
                            AddToCart(
                              productid: _productid,
                            ),
                            //ColorAndSize(product: product),
                            SizedBox(height: 20 / 3),
                            Description(
                              productdetails: _productdetails,
                            ),
                            SizedBox(height: 20 / 3),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
