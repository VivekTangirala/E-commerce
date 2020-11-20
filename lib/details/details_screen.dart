<<<<<<< HEAD:lib/details/details_screen.dart
=======

import 'package:ecom/Homepage/details/components/body.dart';
>>>>>>> f4e9a7327960e73e42f2a68ecf42365414ebb9de:lib/Homepage/details/details_screen.dart
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class DetailsScreen extends StatefulWidget {
  final productid;

  const DetailsScreen({Key key, this.productid}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState(productid);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _productid;

  _DetailsScreenState(this._productid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.grey[300],
      appBar: buildAppBar(context),
      body: Body(
        productid: _productid,
      ),
    );
  }

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
          onPressed: () {},
        ),
        SizedBox(width: 20 / 2)
      ],
    );
  }
}
