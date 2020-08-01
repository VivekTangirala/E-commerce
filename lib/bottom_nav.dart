import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './Homepage/homefragment.dart';
import './Receipe/list_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class BottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNav();
  }
}

class _BottomNav extends State {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(child: HomeFragment()),
            Container(
              child: ReceipeView(),
            ),
            Container(
              color: Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              inactiveColor: Colors.black54,
              activeColor: Color(0xffe75c3c),
              title: Text('  Home',
                  style: Theme.of(context).textTheme.bodyText2),
              icon: Icon(EvaIcons.homeOutline)),
          BottomNavyBarItem(
              inactiveColor: Colors.black54,
              title: Text('Ingredients',
                  style: Theme.of(context).textTheme.bodyText2),
              activeColor: Color(0xffe75c3c),
              icon: Icon(Icons.fastfood)
              ),
          BottomNavyBarItem(
              title: Text('   Profile',
                  style: Theme.of(context).textTheme.bodyText2),
              inactiveColor: Colors.black54,
              activeColor: Color(0xffe75c3c),
              icon: Icon(
                EvaIcons.person,
              )),
        ],
      ),
    );
  }
}
