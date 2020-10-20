import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final Productdetails productdetails;

  const Description({Key key, this.productdetails}) : super(key: key);
  @override
  _DescriptionState createState() => _DescriptionState(productdetails);
}

class _DescriptionState extends State<Description> {
  final Productdetails _productdetails;

  _DescriptionState(this._productdetails);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        _productdetails.results[0].description,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
        maxLines: 8,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
