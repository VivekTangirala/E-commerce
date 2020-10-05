import 'package:ecom/Homepage/details/details_screen.dart';
import 'package:flutter/material.dart';

import 'details/Product.dart';

List<String> list = ["Burger", "Cherry", "Orange", "Apple"];
List<String> list1 = ["A salad between 2 breads", "50", "45", "55"];
List<String> list3 = ["4.5", "5", "4", "2.5"];
final List<String> images = [
  "assets/images/burger.jpeg",
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  'assets/images/some.jpg',
];

class Bestoffers extends StatefulWidget {
  @override
  Bestoffersstate createState() => Bestoffersstate();
}

class Bestoffersstate extends State<Bestoffers> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232.0,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
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
                width: 300,
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  // color: Colors.grey[200],
                  // shape: RoundedRectangleBorder(
                  //   side: BorderSide(color: Colors.white70, width: 1),
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: Column(children: [
                    SizedBox(
                      height: 170,
                      child: Container(
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(images[index])),
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                list1[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                          Text(
                            list3[index],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ])
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
    );
  }
}
