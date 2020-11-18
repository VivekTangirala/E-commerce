import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:ecom/Api/Specialproductsapi/Specialproductsapi.dart';
import 'package:ecom/Api/Specialproductsapi/Specialproductsimport.dart';
import 'package:ecom/Homepage/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

List<String> list = ["Pineapple", "Cherry", "Orange", "Apple", "Apple"];
List<String> list1 = ["25", "50", "45", "55", "55"];
final List<String> images = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  'assets/images/some.jpg',
  'assets/images/some.jpg',
];

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState(); //receivedproductapi);
}

class _DiscoverState extends State<Discover> {
  Productdetails _productdetails;

  List<Specialproductsapi> _specialproducts;
  List mylist, l;
  ScrollController _scrollController = new ScrollController();

  // _DiscoverState(this._productsapi);

  @override
  void initState() {
    super.initState();
    getSpecialProducts();
    // productdetails();
  }

  getSpecialProducts() async {
    await Specialproductsimport.getspecialproudcts().then(
      (value) => setState(
        () {
          _specialproducts =
              value; //__specialproducts gives a list of product ids[]
        },
      ),
    );

    await Productdetailsimport.getProductdetails(
            _specialproducts[0].specialProducts.toList())
        .then((value1) => setState(() {
              _productdetails = value1;
            }));
    print(_specialproducts[0].specialProducts.toList());
    print(_specialproducts[0].specialProducts[0]);

    print(l);
    // productdetails() {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      height: 185.0,
      child: ListView.builder(
        controller: _scrollController,
        itemExtent: 125,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _specialproducts == null
            ? 1
            : _specialproducts[0].specialProducts.length, //images.length+ 1,

        itemBuilder: (BuildContext context, int index) {
          return _productdetails == null
              ? Shimmer.fromColors(
                  child: Center(
                    child: Text(
                      "TREG",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey,
                )
              : GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, bottom: 3),
                    child: SizedBox(
                      // height: 100,
                      width: 120,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: Column(children: [
                          SizedBox(
                            height: 150,
                            child: Container(
                              child: FadeInImage(
                                imageErrorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Container(
                                      decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/tomato.png"),
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ), // set rounded corner radius
                                  ));
                                },
                                placeholder:
                                    AssetImage('assets/images/loading.gif',),
                                image: NetworkImage(_productdetails.results[index].image),
                                fit: BoxFit.cover,
                                
                              ),
                              //alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(height: 0.0),
                          Text(_productdetails.results[index].name),
                        ]),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailsScreen(
                          productid: _productdetails.results[index].id,
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    ));
  }
}
