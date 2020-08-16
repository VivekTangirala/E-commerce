import 'package:flutter/material.dart';

List<String> list = ["Pineapple", "Cherry", "Orange", "Apple"];
List<String> list1 = ["25", "50", "45", "55"];
final List<String> images = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  'assets/images/some.jpg',
];

class Varieties extends StatefulWidget {
  @override
  VarietiesState createState() => VarietiesState();
}

class VarietiesState extends State<Varieties> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return GridView.builder(
      //padding: EdgeInsets.only(right: 15.0),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20.0, mainAxisSpacing: 20.0),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            //margin: EdgeInsets.only(left: 4, bottom: 3),
            child: SizedBox(
              height: 220.0,
              child: Container(
                //margin: EdgeInsets.all(5.0),
                child: Column(children: [
                  SizedBox(
                    height: 161,
                    width: 120.0,
                    child: Container(
                      //alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(images[index])),
                        color: Colors.white,
                        // border: Border.all(
                        //     color: Colors.black12, // set border color
                        //     width: 0.6), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)), // set rounded corner radius
                      ),
                    ),
                  ),
                  // SizedBox(height: 0.0),
                  Text(
                    list[index],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  // Text(
                  //   list1[index],
                  //   style: Theme.of(context).textTheme.caption,
                  // )
                ]),
              ),
            ),
          ),
          onTap: () {},
        );
      },
    );
  }
}
