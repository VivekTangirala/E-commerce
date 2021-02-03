import 'package:ecom/Homepage/Categorylist/categorydata.dart';
import 'package:ecom/Homepage/Categorylist/categoryimport.dart';
import 'package:ecom/Homepage/categoryitems/categoryitems.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  @override
  _Categorylist1State createState() => _Categorylist1State();
}

class _Categorylist1State extends State<Category> {
  List<Categorydata> _categorydata;
  @override
  void initState() {
    super.initState();
    getcategories();
  }
  

  getcategories() async {
    await Categoryimport.getCategoryList().then((value) => setState(() {
          _categorydata = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(80.0),
      width: double.infinity,
      child: _categorydata == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _categorydata.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Hero(
                    tag: 'Categories$index',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Categoryitems(
                            string: _categorydata[index].name,
                          );
                        }));
                      },
                      child: Column(
                        children: [
                          Container(
                              width: getProportionateScreenHeight(50),
                              height: getProportionateScreenHeight(50),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: ClipOval(
                                    child: FadeInImage(
                                      imageErrorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace stackTrace) {
                                        return Container(
                                            // padding: EdgeInsets.only(right:50.0),
                                            decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                                "assets/images/burger.jpeg"),
                                          ),
                                          color: Colors.white,
                                        ));
                                      },
                                      placeholder: AssetImage(
                                        'assets/images/loading.gif',
                                      ),
                                      image: NetworkImage(
                                          _categorydata[index].image),
                                      fit: BoxFit.fill,
                                    ),
                                  ))),
                          Text(
                            _categorydata[index].name,
                            style: Theme.of(context).textTheme.headline5.copyWith(fontSize:14),
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
