import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// List<Color> _chipcolor = [
//   Colors.orangeAccent,
//   Colors.orangeAccent,
//   Colors.orangeAccent,
//   Colors.orangeAccent,
//   Colors.orangeAccent,
//   Colors.orangeAccent,
// ];
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
          tabs: List<Widget>.generate(images.length, (int index) {
            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(images[index]), fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    _name[index],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          })

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
    final Rect rect = Offset(offset.dx, 0) & Size(configuration.size.width, 0);
    //final Rect rect = offset & configuration.size;
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(0.0)), paint);
  }
}
