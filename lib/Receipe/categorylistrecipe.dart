import 'package:ecom/Cart/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

List<Color> _chipcolor = [
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
  Colors.orangeAccent,
];

List<Text> _ingredients = [
  Text("Fruits & vegetables",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)),
  Text("Snacks",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Staples",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Beaverages",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Bakery & dairy",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
  Text("Personal care",
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)),
];

class Categorylistrecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Categorylistrecipestate();
  }
}

class Categorylistrecipestate extends State<Categorylistrecipe> {
  @override
  Widget build(BuildContext context) {
    // int _tabindex = 0;
    // var tab = TabController(initialIndex: 0, length: 3, vsync: this);
    // void _handleTabselection() {
    //   setState(() {
    //     tab.index = _tabindex;
    //   });
    // }

    // tab.addListener(() {
    //   _handleTabselection();
    // });
    return DefaultTabController(
      length: 6,
      child: TabBar(
        physics: ScrollPhysics(),

        isScrollable: true,
        //controller: tab,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: CustomTabindicator(),
        //BubbleTabIndicator(
        //     indicatorHeight: 25.0,
        //     indicatorColor: Colors.orange,
        //     tabBarIndicatorSize: TabBarIndicatorSize.tab),
        tabs: [
          // ListView.builder(
          //     itemCount: _ingredients.length,
          //     physics: ScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Text("data",
          //           style: TextStyle(
          //             color: Colors.black,
          //           ));
          //     }),
          Text("Popular",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal)),
          Text("Top",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal)),
          Text("Breakfast",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal)),
          Text("Lunch",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal)),
          Text("Snacks",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal)),
          Text("Dinner",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}

class CustomTabindicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabindicator decoration;
  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect =
        Offset(offset.dx, (configuration.size.height / 2 - 24 / 2)) &
            Size(configuration.size.width, 24);
    //final Rect rect = offset & configuration.size;
    final Paint paint = Paint();
    paint.color = Colors.orangeAccent;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(20.0)), paint);
  }
}
