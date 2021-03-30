import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecom/Cart/Cartapi.dart';
import 'package:ecom/Cart/Cartapiimport.dart';
import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:ecom/Cart/Cartapiremove.dart';
import 'package:ecom/Payments/Createordersapi.dart';
import 'package:ecom/Payments/Createordersimport.dart';
import 'package:ecom/Payments/checkout.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart1 extends StatefulWidget {
  @override
  _Cart1State createState() => _Cart1State();
}

class _Cart1State extends State<Cart1> {
  Cartapi _cartapidata;
  Createorderapi _orderdetails;
  List _qty;
  bool firstload = false;
  List<String> _cartproducts = [];
  @override
  void initState() {
    super.initState();
    _refreshcart();
  }

  _refreshcart() async {
    await CartApiimport.getCart().then((value) {
      setState(() {
        _cartapidata = value;
        _counters();
      });
    });
    firstload = true;
  }

  _deleteproduct(delproductid) async {
    await Cartapiremove.removefromcart(delproductid.toString())
        .then((value) => setState(() {
              _refreshcart();
            }));
  }

  _createorder() async {
    await Createordersimport.getorderdetails().then(
      (value) => setState(
        () {
          _orderdetails = value;
        },
      ),
    );
  }

  _counters() {
    if (_cartapidata != null) {
      _qty = new List.generate(_cartapidata.cart.length, (index) => 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: firstload == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _cartapidata.cart.length == 0
              ? Center(
                  child: Text("Your cart is empty."),
                )
              : Container(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                      itemCount: _cartapidata.cart.length,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FadeInImage(
                                imageErrorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Container(
                                    padding: EdgeInsets.all(5.0),
                                    height: getProportionateScreenHeight(120.0),
                                    width: getProportionateScreenWidth(140.0),
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
                                  _cartapidata.cart[index].product.image,
                                ),
                                fit: BoxFit.fill,
                                width: getProportionateScreenWidth(140.0),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(0.0),
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
                                        Text(
                                            _cartapidata
                                                .cart[index].product.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2),
                                        // Text(
                                        //   "Cocktail dress",
                                        // ),

                                        // Text(
                                        //   "Cocktail dress",
                                        // ),
                                        Row(
                                          children: [
                                            Text("Quantity : "),
                                            Text(
                                              _cartapidata.cart[index].quantity
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Price:-",
                                            ),
                                            Text(
                                              _cartapidata
                                                  .cart[index].product.price
                                                  .toString(),
                                            ),
                                            Text("/KG"),
                                          ],
                                        ),
                                        // Text(
                                        //   "Color: Yellow",
                                        // ),
                                        SizedBox(
                                          height: getProportionateScreenHeight(
                                              15.0),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: Colors.orangeAccent,
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  _qty[index] = _qty[index] + 1;
                                                });
                                                await _cartquantity(
                                                  _cartapidata
                                                      .cart[index].product.id
                                                      .toString(),
                                                  (int.parse(_cartapidata
                                                              .cart[index]
                                                              .product
                                                              .quantity) +
                                                          1)
                                                      .toString(),
                                                );
                                                setState(() {
                                                  _refreshcart();
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _cartapidata.cart[index].quantity
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.orangeAccent,
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  if (_qty[index] > 1) {
                                                    _qty[index] =
                                                        _qty[index] - 1;
                                                  }
                                                });
                                                if (_cartapidata
                                                        .cart[index].quantity >
                                                    1) {
                                                  await _cartquantity(
                                                    _cartapidata
                                                        .cart[index].product.id
                                                        .toString(),
                                                    (int.parse(_cartapidata
                                                                .cart[index]
                                                                .product
                                                                .quantity) -
                                                            1)
                                                        .toString(),
                                                  );
                                                  setState(() {
                                                    _refreshcart();
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(
                                                    4.0),
                                          ),
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            onPressed: () => {
                                              _deleteproduct(_cartapidata
                                                  .cart[index].product.id)
                                            },
                                            color: Colors.redAccent,
                                            child: Text(
                                              "Remove",
                                              style: TextStyle(
                                                  fontSize: 15,
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
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Subtotal:-",
                                    ),
                                    Text(
                                      "Discount:-",
                                    ),
                                    Text(
                                      "Total:-",
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "25",
                                  ),
                                  Text(
                                    _cartapidata
                                        .cart[index].product.discountPercentage
                                        .toString(),
                                  ),
                                  Text(
                                    "5000",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]));
                      }),
                ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
      ),
      title: Text("Cart",
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
            onPressed: () async {
              await _createorder();
              _orderdetails == null
                  ? CupertinoAlertDialog(
                      actions: [CircularProgressIndicator()],
                    )
                  : Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return Checkout(
                          id: _orderdetails.orders.id,
                          amount: _orderdetails.orders.amount.toString(),
                          currency: _orderdetails.orders.currency,
                        );
                      }),
                    );
            },
            color: Colors.orangeAccent,
            child: Text(
              "Checkout",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  _cartquantity(String _product, _quantity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    Map data = {'product': _product, 'quantity1': _quantity};
    var jsonresponse;
    var response = await http.post(
        "https://infintymall.herokuapp.com/homepage/api/cart",
        body: data,
        headers: {HttpHeaders.authorizationHeader: token});
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
  }
}
