import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class Categorylist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Categoryliststate();
  }
}

class Categoryliststate extends State<Categorylist> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
               indicator: CustomTabIndicator(),//BubbleTabIndicator(
              //     indicatorHeight: 25.0,
              //     indicatorColor: Colors.orange,
              //     tabBarIndicatorSize: TabBarIndicatorSize.tab),
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.directions_car,
                  color: Colors.black,
                )),
                Tab(
                    icon: Icon(
                  Icons.directions_transit,
                  color: Colors.black,
                )),
                Tab(
                    icon: Icon(
                  Icons.directions_bike,
                  color: Colors.black,
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Icon(
                Icons.directions_car,
                color: Colors.black,
              ),
              Icon(
                Icons.directions_transit,
                color: Colors.black,
              ),
              Icon(
                Icons.directions_bike,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
       return new _customPainter(this, onChanged);
  }
}

class _customPainter extends BoxPainter {
  
  final CustomTabIndicator decoration;
  _customPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final Paint paint = Paint();
    paint.color = Colors.blueAccent;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(10.0)), paint);
        
  }
}
