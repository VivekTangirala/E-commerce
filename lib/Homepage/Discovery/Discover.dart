import 'package:ecom/Api/Productapi/Productapi.dart';
import 'package:ecom/Api/Specialproductsapi/Specialproductsapi.dart';
import 'package:ecom/Api/Specialproductsapi/Specialproductsimport.dart';
import 'package:ecom/Homepage/details/Product.dart';
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
  final Productsapi receivedproductapi;

  const Discover({Key key, this.receivedproductapi}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState(receivedproductapi);
}

class _DiscoverState extends State<Discover> {
  final Productsapi _productsapi;
  List<Specialproductsapi> _specialproducts;
  bool _isloading = true;
  List mylist;
  List mylist1;
  ScrollController _scrollController = new ScrollController();

  _DiscoverState(this._productsapi);

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() {
    Specialproductsimport.getspecialproudcts().then(
      (value) => setState(
        () {
          _specialproducts = value;
          _isloading = false;
          print(_specialproducts[0].specialProducts.length);
        },
      ),
    );
  }
  // getMoreData() {
  //   print("Reached limit");
  //   for (var i = _currentmax; i < _currentmax + 4; i++) {
  //     images.add("assets/images/burger.jpeg");
  //     list.add("Burger");
  //   }
  //   _currentmax = _currentmax + 4;
  //   setState(() {});
  // }

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
          // if (index == images.length) {
          //   return NutsActivityIndicator(
          //     radius: 15.0,
          //     animationDuration: Duration(seconds: 1),
          //   );
          // }
          return _specialproducts == null
              ? Shimmer.fromColors(
                  child: Center(
                    child: Text("TREG",style: TextStyle(fontSize:30),),
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
                                        image: AssetImage(_productsapi
                                            .results[_specialproducts[0]
                                                    .specialProducts[index] -
                                                1]
                                            .image)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ), // set rounded corner radius
                                  ));
                                },
                                placeholder:
                                    AssetImage('assets/images/loading.gif'),
                                image: NetworkImage(_productsapi
                                    .results[_specialproducts[0]
                                            .specialProducts[index] -
                                        1]
                                    .image),
                                fit: BoxFit.cover,
                                // height: 100.0,
                                // width: 100.0,
                              ),
                              //alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(height: 0.0),
                          Text(
                            _productsapi
                                .results[
                                    _specialproducts[0].specialProducts[index] -
                                        1]
                                .name,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailsScreen(
                          productid: _specialproducts[0].specialProducts[index],
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
