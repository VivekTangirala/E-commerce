import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  var _qty=1, _discount, _subtotal, _total;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Expanded(
              child: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: l1.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Image.asset(
                                l1[index],
                                width: 150,
                                height: 180,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(l2[index]),
                                    // Text(
                                    //   "Cocktail dress",
                                    // ),
                                    Text("Quantity: $_qty"),
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
                                          l3[index],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.add_circle,
                                                  color: Colors.orangeAccent,
                                                ),
                                                onPressed:(){
                                                  setState(() {
                                                    _qty=_qty+1;
                                                  });
                                                },
                                                ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                             "$_qty",
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.orangeAccent,
                                                ),
                                                onPressed:(){
                                                  setState(() {
                                                    _qty=_qty-1;
                                                  });
                                                },
                                                ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
                  );
                }),
          ))),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          CupertinoIcons.back,
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