import 'package:ecom/Homepage/Discovery/Discoverdata.dart';
import 'package:ecom/Homepage/Discovery/discoverimport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

List<String> list = ["Pineapple", "Cherry", "Orange", "Apple"];
List<String> list1 = ["25", "50", "45", "55"];
final List<String> images = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  'assets/images/some.jpg',
];

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  Discoverdata _discoverdata;
  bool _isloading = true;
  List mylist;
  List mylist1;
  ScrollController _scrollController = new ScrollController();
  int _currentmax = 4;
  @override
  void initState() {
    super.initState();
    Discoverimport.getUsers().then((value) {
      _discoverdata = value;
      _isloading = false;
    });
    // mylist = List.generate(4, (i) => "assets/images/tomato.png");
    // mylist1 = List.generate(4, (i) => "Pineapple");
    // _scrollController.addListener(
    //   () {
    //     if (_scrollController.position.pixels ==
    //         _scrollController.position.maxScrollExtent) {
    //       getMoreData();
    //     }
    //   },
    // );
  }

  getMoreData() {
    print("Reached limit");
    for (var i = _currentmax; i < _currentmax + 4; i++) {
      images.add("assets/images/burger.jpeg");
      list.add("Burger");
    }
    _currentmax = _currentmax + 4;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_discoverdata);
    return SizedBox(
      height: 350.0,
      child: ListView.builder(
        controller: _scrollController,
        itemExtent: 125,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _discoverdata == null
            ? 0
            : _discoverdata.results.length, //images.length+ 1,

        itemBuilder: (BuildContext context, int index) {
          // if (index == images.length) {
          //   return NutsActivityIndicator(
          //     radius: 15.0,
          //     animationDuration: Duration(seconds: 1),
          //   );
          // }
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
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("url"),
                            //image: AssetImage(images[index]),
                          ),
                          color: Colors.white,
                          // border: Border.all(
                          //     color: Colors.black12, // set border color
                          //     width: 0.6), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0)), // set rounded corner radius
                        ),
                      ),
                    ),
                    SizedBox(height: 0.0),
                    // _isloading == true
                    //     ? Column(
                    //         children: [
                    //           Text(
                    //             list[index],
                    //             style: Theme.of(context).textTheme.bodyText1,
                    //           ),
                    //           Text(
                    //             "25",
                    //             style: Theme.of(context).textTheme.caption,
                    //           )
                    //         ],
                    //       )
                    //     :
                    Text(
                      _discoverdata.results[index].name,
                    ),
                  ]),
                ),
              ),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
