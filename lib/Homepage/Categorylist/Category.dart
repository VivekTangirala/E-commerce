import 'package:ecom/Api/Categoryapi/categorydata.dart';
import 'package:ecom/Api/Categoryapi/categoryimport.dart';
import 'package:ecom/Api/Categorydetailsapi/Categorydetailsimport.dart';
import 'package:ecom/Homepage/categoryitems/categoryitems.dart';
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

class Category extends StatefulWidget {
  @override
  _Categorylist1State createState() => _Categorylist1State();
}

class _Categorylist1State extends State<Category> {
  List<Categorydata> _categorydata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategories();
  }

  getcategories() async {
    await Categoryimport.getUsers().then((value) => setState(() {
          _categorydata = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      child: _categorydata == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Categoryitems(
                            string: _categorydata[index].name.toString(),
                          );
                        }));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(_categorydata == null
                                      ? "assets/images/loading.gif"
                                      : _categorydata[index].image),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Text(
                            _categorydata[index].name,
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