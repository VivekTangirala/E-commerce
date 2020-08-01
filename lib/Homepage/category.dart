import 'package:ecom/placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './just_for_you.dart';

class Category extends StatelessWidget {
  final a = true;
  final List<String> list = [
    'anitesh',
    'harnav',
    'munna',
    'dhed',
  ];
  final List<String> images = [
    'assets/images/earphones.jpg',
    'assets/images/sandals.jpg',
    'assets/images/drinks.jpg',
    'assets/images/some.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.0,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
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
                width: 160,
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  // color: Colors.grey[200],
                  // shape: RoundedRectangleBorder(
                  //   side: BorderSide(color: Colors.white70, width: 1),
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: Column(children: [
                    SizedBox(
                      height: 120,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(images[index])),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black12, // set border color
                              width: 0.6), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 3, left: 3, right: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            "Vegetables",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        )),
                    Container(
                      margin:
                          EdgeInsets.only( left: 20, right: 3,),
                      child: Center(
                        child: Row(children: [
                          Text(
                            "Up to",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          
                          StrikeThroughWidget(
                            child: Text(
                              "30%",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Text(
                            "off",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ]),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Screentwo(value: list[index])));
            },
          );
        },
      ),
    );
  }
}

class StrikeThroughWidget extends StatelessWidget {
  final Widget _child;

  StrikeThroughWidget({Key key, @required Widget child})
      : this._child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _child,
      padding: EdgeInsets.symmetric(
          horizontal:
              8), // this line is optional to make strikethrough effect outside a text
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/strike_through.png'),
            fit: BoxFit.fitWidth),
      ),
    );
  }
}
