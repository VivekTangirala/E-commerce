import 'package:ecom/Homepage/details/Product.dart';
import 'package:ecom/Homepage/details/components/cart_counter.dart';
import 'package:ecom/Homepage/details/components/counter_with_fav_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          CartCounter(),
           //Spacer(),
          // Container(
          //   margin: EdgeInsets.only(right: 20),
          //   height: 40,
          //   width: 58,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(18),
          //     border: Border.all(
          //       color: product.color,
          //     ),
          //   ),
          //   child: IconButton(
          //     icon: Icon(Icons.add_shopping_cart),
          //     onPressed: () {},
          //   ),
          // ),
         
          SizedBox(width: 30,),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.orange,
                onPressed: () {},
                child: Text(
                  "Add to Cart".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
