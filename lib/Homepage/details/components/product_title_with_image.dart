
import 'package:ecom/Homepage/details/Product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 200, 
            margin: EdgeInsets.only(top: 16),
            child: Text ( product.title ,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dMSans(color: Colors.black, fontSize: 25)),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text("save  20%",
                style: GoogleFonts.dMSans(
                  color: Colors.orange,
                  fontSize: 16,
                )),
          ),
        ]),
        Container(
          margin: EdgeInsets.only(top: 16),
            child: Row(children: <Widget>[
          Text.rich(
            TextSpan(
              //text: 'This item costs ',
              children: <TextSpan>[
                new TextSpan(
                  text: ' \$3.99',
                  style: new TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    
                  ),
                ),
               TextSpan(text: "  "),
                new TextSpan(
                  text: '\$8.99',
                  style: new TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),

        ])),
      ],
    );
  }
}
