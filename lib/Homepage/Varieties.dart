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

class VarietiesState extends State<Varieties>
    with AutomaticKeepAliveClientMixin {
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = screenSize(context).width;
    var height = screenSize(context).height;
    return GridView.builder(
      //padding: EdgeInsets.only(right: 15.0),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15.0, mainAxisSpacing: 25.0),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Column(children: [
            SizedBox(
              height: height / 5.8,
              width: width / 2.5,
              child: Container(
                //alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(images[index])),
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
          onTap: () {

          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
