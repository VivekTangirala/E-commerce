import 'package:ecom/Homepage/Categorylist/categorylistdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'categorylistimport.dart';

class Categorylist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Categoryliststate();
  }
}

class Categoryliststate extends State<Categorylist> {
  List<Categorydata> _categorydata;
  bool _isLoading = true;

  @override
  // var response = await http
  //       .post("https://infintymall.herokuapp.com/user/api/login", body: data);
  void initState() {
    super.initState();
    // if () {

    // }
    refreshCategory();
  }

  refreshCategory() {
    Categorylistimport.getUsers().then((value) {
      setState(() {
        _categorydata = value;
        _isLoading = false;
      });
    });
    setState(() {
      _isLoading = true;
    });
  }

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
      length: _categorydata == null ? 1 : _categorydata.length,
      child: GestureDetector(
        onTap: () {
          // if (index==1) {

          // }
        },
        child: TabBar(
          physics: ScrollPhysics(),
          isScrollable: true,
          //controller: tab,
          indicatorSize: TabBarIndicatorSize.tab,
          // onTap: (){
          //   setState(() {

          //   });
          // },
          indicator: _isLoading == true ? null : CustomTabindicator(),
          //BubbleTabIndicator(
          //     indicatorHeight: 25.0,
          //     indicatorColor: Colors.orange,
          //     tabBarIndicatorSize: TabBarIndicatorSize.tab),
          tabs: List<Widget>.generate(
              _categorydata == null ? 1 : _categorydata.length, (int index) {
            return _categorydata == null
                ? CircularProgressIndicator()
                : Text(_categorydata[index].name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal));
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

          // _isLoading == true
          //     ? Text(_categorydata.results[0].name.toString(),
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 18.0,
          //             fontWeight: FontWeight.normal))
          //     : Center(
          //         child: Image.asset('assets/images/loading.gif',height: 50.0,),
          //       ),

          ,
        ),
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
