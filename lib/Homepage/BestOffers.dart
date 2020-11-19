import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:ecom/Api/Specialproductsapi/Specialproductsapi.dart';
import 'package:ecom/Api/Specialproductsapi/Specialproductsimport.dart';
import 'package:ecom/Homepage/details/details_screen.dart';
import 'package:flutter/material.dart';

// List<String> list = ["Burger", "Cherry", "Orange", "Apple", "Apple"];
// List<String> list1 = ["A salad between 2 breads", "50", "45", "55", "55"];
// List<String> list3 = ["4.5", "5", "4", "2.5", "2.5"];
// final List<String> images = [
//   "assets/images/burger.jpeg",
//   "assets/images/tomato.png",
//   "assets/images/onion.jpeg",
//   'assets/images/some.jpg',
//   'assets/images/some.jpg',
// ];

class Bestoffers extends StatefulWidget {
  @override
  Bestoffersstate createState() => Bestoffersstate();
}

class Bestoffersstate extends State<Bestoffers> {
  List<Specialproductsapi> _specialproducts;
  Productdetails _productdetails;

  @override
  void initState() {
    super.initState();
    getspecialproducts();
  }

  getspecialproducts() async {
    await Specialproductsimport.getspecialproudcts().then(
      (value) => setState(
        () {
          _specialproducts = value;
          print(_specialproducts[0].specialProducts.length);
        },
      ),
    );
    await Productdetailsimport.getProductdetails(
            _specialproducts[0].specialProducts.toList())
        .then((value1) => setState(() {
              _productdetails = value1;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232.0,
      child: _productdetails != null
          ? ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _specialproducts[0].specialProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, bottom: 3),
                
                    child: SizedBox(
                      // height: 100,
                      width: 300,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                       
                        child: Column(children: [
                          SizedBox(
                            height: 170,
                            child: Container(
                              child: FadeInImage(
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
                              //alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(height: 0.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _productdetails.results[index].name,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      _productdetails
                                          .results[index].description,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                                Text(
                                  _productdetails.results[index].offerPrice
                                      .toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ])
                        ]),
                      ),
                    ),
                  ),
                  onTap: () {
                    // if (_specialproducts != null) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (BuildContext context) => DetailsScreen(
                    //         productid:
                    //             _specialproducts[0].specialProducts[index].toList(),
                    //       ),
                    //     ),
                    //   );
                    // }
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
