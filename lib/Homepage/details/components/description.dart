import 'package:ecom/Homepage/details/Product.dart';
import 'package:flutter/material.dart';


class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        product.description+product.description,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
        maxLines: 8,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
