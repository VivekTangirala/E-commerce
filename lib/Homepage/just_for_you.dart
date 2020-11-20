import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class SpecialProducts extends StatelessWidget {
final  bool a = true;
  final List<String> images = [
    'assets/images/earphones.jpg',
    'assets/images/sandals.jpg',
    'assets/images/drinks.jpg',
    'assets/images/some.jpg',
  ];
  final List<String> list = [
    'anitesh',
    'harnav',
    'munna',
    'dhed',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right:6),
        child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            itemCount: 3,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 6 / 5),
            itemBuilder: (BuildContext context, int index) {
              AspectRatio(aspectRatio: 10 / 1);
              return new GestureDetector(
                child: a == true ? _badge(index) : _badgeless(index),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Screentwo(value: list[index])));
                },
              );
            }));
  }

  Widget _badge(int index) {
    return Badge(
      badgeContent: Image.asset('assets/images/india-flag.png',
          height: 16, width: 26, fit: BoxFit.fill),
      badgeColor: Colors.white,
     // borderRadius: 15,
      shape: BadgeShape.square,
    //  position: BadgePosition.topLeft(top: 6, left: 6),
      child: Container(
        margin: EdgeInsets.only(left: 6, bottom: 6),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(images[index])),
          color: Colors.white,
          border: Border.all(
              color: Colors.black12, // set border color
              width: 0.6),
               // set border width
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // set rounded corner radius
        ),
        
        
      ),
    );
  }

  Widget _badgeless(int index) {
    return Container(
      margin: EdgeInsets.only(left: 6, bottom: 6),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // image: DecorationImage(
        //     fit: BoxFit.fill,
        //     image: NetworkImage(
        //         'https://infintymall.herokuapp.com/media/pics/Screenshot_from_2020-06-06_23-21-23.png')),
        color: Colors.white,
        border: Border.all(
            color: Colors.black12, // set border color
            width: 0.6), // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // set rounded corner radius
      ),
    );
  }
}

class Screentwo extends StatefulWidget {
  final String value;
  const Screentwo({Key key, this.value}) : super(key: key);
  @override
  _ScreentwoState createState() => _ScreentwoState(value);
}

class _ScreentwoState extends State<Screentwo> {
  String value;
  _ScreentwoState(this.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second",style:Theme.of(context).textTheme.headline3,),
        ),
        body: Text(value));
  }
}
