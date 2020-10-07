import 'package:ecom/Homepage/Discovery/Discoverdata.dart';
import 'package:ecom/Homepage/details/Product.dart';
import 'package:ecom/Homepage/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

List<String> list = ["Pineapple", "Cherry", "Orange", "Apple"];
List<String> list1 = ["25", "50", "45", "55"];
final List<String> images = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  'assets/images/some.jpg',
];

class Discover extends StatefulWidget {
  final Discoverdata receiveddiscoverdata;

  const Discover({Key key, this.receiveddiscoverdata}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState(receiveddiscoverdata);
}

class _DiscoverState extends State<Discover> {
  _DiscoverState(this._discoverdata);
  final Discoverdata _discoverdata;
  List mylist;
  List mylist1;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
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
        itemCount: _discoverdata == null
            ? 1
            : _discoverdata.results.length, //images.length+ 1,

        itemBuilder: (BuildContext context, int index) {
          // if (index == images.length) {
          //   return NutsActivityIndicator(
          //     radius: 15.0,
          //     animationDuration: Duration(seconds: 1),
          //   );
          // }
          return _discoverdata == null
              ? Container(child:FlutterLogo())
              : GestureDetector(
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
                      width: 120,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        // color: Colors.grey[200],
                        // shape: RoundedRectangleBorder(
                        //   side: BorderSide(color: Colors.white70, width: 1),
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
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
                                            'assets/images/burger.jpeg')),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ), // set rounded corner radius
                                  ));
                                },
                                placeholder:
                                    AssetImage('assets/images/loading.gif'),
                                image: NetworkImage(
                                    _discoverdata.results[index].image),
                                fit: BoxFit.cover,
                                // height: 100.0,
                                // width: 100.0,
                              ),
                              //alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(height: 0.0),
                          Text(
                            _discoverdata.results[index].name,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailsScreen(
                          product: products[index],
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
