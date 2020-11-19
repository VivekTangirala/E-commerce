import 'package:ecom/Api/Brandapi/Brandapi.dart';
import 'package:ecom/Api/Brandapi/Brandapiimport.dart';
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

class Brand extends StatefulWidget {
  @override
  Brandstate createState() => Brandstate();
}

class Brandstate extends State<Brand> {
  List<Brandapi> _brandapi;

  @override
  void initState() {
    super.initState();
    refreshbrand();
  }

  refreshbrand() {
    Brandapiimport.getbrandlist().then(
      (value) => setState(
        () {
          _brandapi = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110.0,
      child: _brandapi != null
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: _brandapi.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, bottom: 3),
                    // decoration: BoxDecoration(
                    //   // border: Border.all(width: 1.0),
                    //   borderRadius: BorderRadius.all(
                    //       Radius.circular(20.0) //         <--- border radius here
                    //       ),
                    // ),
                    child: SizedBox(
                      // height: 100,
                      width: 100,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        // color: Colors.grey[200],
                        // shape: RoundedRectangleBorder(
                        //   side: BorderSide(color: Colors.white70, width: 1),
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                            child: FadeInImage(
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Container(
                                    decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/images/drinks.jpg"),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ), // set rounded corner radius
                                ));
                              },
                              placeholder:
                                  AssetImage('assets/images/loading.gif'),
                              image: NetworkImage(_brandapi[index].img),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 0.0),
                          Text(
                            _brandapi[index].name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
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
