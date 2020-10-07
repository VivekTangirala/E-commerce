import 'package:flutter/material.dart';

List<String> images = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
  "assets/images/some.jpg",
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
];
List<String> _name = [
  "Popular",
  "Top",
  "Breakfast",
  "Lunch",
  "Snacks",
  "Dinner",
];

class Categorylist1 extends StatefulWidget {
  @override
  _Categorylist1State createState() => _Categorylist1State();
}

class _Categorylist1State extends State<Categorylist1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      child: ListView.builder(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Hero(
                tag: 'Categories$index',
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Text(
                        _name[index],
                        style: Theme.of(context).textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
