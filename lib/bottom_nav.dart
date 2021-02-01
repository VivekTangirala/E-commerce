//

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecom/Homepage/homefragment.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'Receipe/Recipihome/Recipihome.dart';

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
            // Container(
            //   child: RecipiHome(),
            // ),
            // Container(
            //  child: ProfileFirst(),
            // ),
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
              activeColor: Colors.black,
              title:
                  Text('  Home', style: Theme.of(context).textTheme.bodyText2),
              icon: Icon(EvaIcons.homeOutline)),
          BottomNavyBarItem(
              inactiveColor: Colors.black54,
              title:
                  Text('Recipe', style: Theme.of(context).textTheme.bodyText2),
              activeColor: Colors.black,
              icon: Icon(Icons.fastfood)),
         
        ],
      ),
    );
  }
}
