import 'package:ecom/Cart/cart.dart';
import 'package:ecom/Wishlist/Wishlist.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar appBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    leading: Container(
        padding: EdgeInsets.all(16),
        width: 15,
        height: 15,
        child: InkWell(
          child: SvgPicture.asset(
            "assets/icons/menu.svg",
            height: 15,
            width: 15,
            color: Colors.black,
          ),
          onTap: () {
            scaffoldKey.currentState.openDrawer();
          },
        )),
    centerTitle: true,
    title: Center(
      child: Text(
        "Treg Mart",
        style: Theme.of(context).textTheme.headline3,
      ),
    ),
    actions: [
      IconButton(
        padding: EdgeInsets.only(left: 20),
        icon: Icon(
          EvaIcons.heartOutline,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Wishlist();
              },
            ),
          );
          //  showSearch(context: context, delegate: SearchBar());
        },
      ),
      IconButton(
        icon: Icon(
          EvaIcons.shoppingCartOutline,
          color: Colors.black,
        ),
        padding: EdgeInsets.only(left: 20, right: 16),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart1()),
          );
        },
      ),
    ],
  );
}
