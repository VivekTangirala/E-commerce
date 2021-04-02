import 'package:ecom/components/productAppBar.dart';
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
}
