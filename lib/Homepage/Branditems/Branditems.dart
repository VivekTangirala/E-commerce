import 'dart:convert';
import 'dart:io';
import 'package:ecom/Homepage/Brand/Brandapiimport.dart';
import 'package:ecom/Homepage/Branditems/Branditemimport.dart';
import 'package:ecom/Homepage/Branditems/Branditemsapi.dart';
import 'package:ecom/components/logInPopup.dart';
import 'package:http/http.dart' as http;
import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Cart/cart.dart';
import 'package:ecom/components/screensize.dart';
import 'package:ecom/productDetails/details_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Branditems extends StatefulWidget {
  final String brandname;
  const Branditems({Key key, this.brandname}) : super(key: key);
  @override
  _BranditemsState createState() => _BranditemsState(brandname);
}

class _BranditemsState extends State<Branditems> {
  final String _brandname;

  String token;

  _BranditemsState(this._brandname);

  List<Productdetails> _productdetails;

  List<Branditemsapi> _branditems;
  var _statuscode;

  List<bool> _inwhishlist = List<bool>.generate(10, (index) => false);
  @override
  void initState() {
    getToken();
    _getbranditems();
    super.initState();
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  _getbranditems() async {
    await Branditemimport.getbranditems(_brandname)
        .then((value) => setState(() {
              _branditems = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  _body() {
    return _branditems == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8.0),
              vertical: getProportionateScreenHeight(8.0),
            ),
            child: ListView.builder(
              itemCount: _branditems.length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FadeInImage(
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Container(
                                  padding: EdgeInsets.all(5.0),
                                  height: getProportionateScreenHeight(100.0),
                                  width: getProportionateScreenWidth(100.0),
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
                                _branditems[index].image,
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
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(_branditems[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2),
                                      Text(
                                          "Price - ₹" +
                                              _branditems[index]
                                                  .offerPrice
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 13)),
                                      Text(
                                        "Discount -" +
                                            _branditems[index]
                                                .discountPercentage
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13),
                                      ),
                                      Text(
                                          "You save - ₹" +
                                              (_branditems[index].price -
                                                      _branditems[index]
                                                          .offerPrice)
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 13)),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(15.0),
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
                                              getProportionateScreenWidth(4.0),
                                        ),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          onPressed: () async {
                                            if (token == null) {
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
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                        "Added to cart"),
                                                    duration:
                                                        Duration(seconds: 5),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DetailsScreen(
                        productid: 2,
                      );
                    }));
                  },
                );
              },
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
      title: Text(
        _brandname,
        style: GoogleFonts.lato(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey.shade100,
      actions: [
        IconButton(
          icon: Icon(
            EvaIcons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            EvaIcons.shoppingCartOutline,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return Cart1();
              }),
            );
          },
        ),
        SizedBox(width: 20 / 2)
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
