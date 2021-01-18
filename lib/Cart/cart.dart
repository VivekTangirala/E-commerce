import 'package:ecom/Cart/Cartapi.dart';
import 'package:ecom/Cart/Cartapiimport.dart';
import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

List<String> l1 = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  ",assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
];
List<String> l2 = [
  "Tomatoes",
  "Onions",
  "Burger",
];
List<String> l3 = [
  "10.5",
  "15.25",
  "50.0",
];

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Cartapi _cartapidata;
  Productdetails _productdetails;
  var _qty;
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
    
    for (var i = 0; i < _cartapidata.cart.length; i++) {
      _cartproducts.add(_cartapidata.cart[i].productId.toString());
    }
    Productdetailsimport.getProductdetails(_cartproducts)
        .then((value) => setState(() {
              _productdetails = value;
            }));
  }

  _counters() {
    if (_cartapidata.cart != null) {
      _qty = new List.generate(_cartapidata.cart.length, (index) => 1);
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _cartapidata == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : LiquidPullToRefresh(
              onRefresh: () {
                return _refreshcart();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                    itemCount: _cartapidata.cart.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: Column(children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              FadeInImage(
                                imageErrorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
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
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(_productdetails.results[index].name),
                                      // Text(
                                      //   "Cocktail dress",
                                      // ),
                                      Row(
                                        children: [
                                          Text(_productdetails
                                              .results[index].name),
                                          // Text(
                                          //   "Cocktail dress",
                                          // ),
                                          Row(
                                            children: [
                                              Text("Quantity:"),
                                              Text(_productdetails
                                                  .results[index].quantity)
                                            ],
                                          ),
                                          // Text(
                                          //   "Color: Yellow",
                                          // ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _productdetails
                                                    .results[index].price
                                                    .toString(),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.add_circle,
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _qty[index] =
                                                            _qty[index] + 1;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(_productdetails
                                                      .results[index].quantity),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.remove_circle,
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_qty[index] > 1) {
                                                          _qty[index] =
                                                              _qty[index] - 1;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Subtotal",
                                        ),
                                        Text(
                                          "25",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Delivery",
                                        ),
                                        Text(
                                          "\$0",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Discount",
                                        ),
                                        Text(
                                          "No discount",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total",
                                        ),
                                        Text(
                                          "5000",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ]));
                    }),
              ),
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
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
            onPressed: () => {},
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
}
