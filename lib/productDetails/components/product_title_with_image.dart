import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitleWithImage extends StatefulWidget {
  final String productdetails;

  const ProductTitleWithImage({Key key, this.productdetails}) : super(key: key);
  @override
  _ProductTitleWithImageState createState() =>
      _ProductTitleWithImageState(productdetails);
}

class _ProductTitleWithImageState extends State<ProductTitleWithImage> {
  final String _productdetails;

  _ProductTitleWithImageState(this._productdetails);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 16),
            child: Text(_productdetails,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dMSans(color: Colors.black, fontSize: 25)),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text("save ",
                style: GoogleFonts.dMSans(
                  color: Colors.deepOrange,
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
                        color: Colors.deepOrange,
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
