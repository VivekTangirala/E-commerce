import 'package:ecom/Cart/cart.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          EvaIcons.search,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          EvaIcons.shoppingCartOutline,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return Cart1();
          }),);
        },
      ),
      SizedBox(width: 20 / 2)
    ],
  );
}
