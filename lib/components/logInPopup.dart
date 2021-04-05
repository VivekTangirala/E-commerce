import 'dart:ui';
import 'package:ecom/Login/newSignIn/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text, image;

  const CustomDialogBox(
      {Key key,
      @required this.title,
      @required this.descriptions,
      this.text,
      @required this.image})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() =>
      _CustomDialogBoxState(title, descriptions, text, image);
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final String title, descriptions, details, image;

  _CustomDialogBoxState(
      this.title, this.descriptions, this.details, this.image);
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ));
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 15, top: 25, right: 15, bottom: 15),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 7,
                ),
                Text(
                  "$title",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "$descriptions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                            );
                          },
                          child: Text(
                            "SignIn",
                            style: TextStyle(
                                fontSize: 16, color: Colors.deepOrange),
                          )),
                    )
                  ],
                ),
              ],
            )),
        Positioned(
          left: 20,
          right: 20,
          top: 15,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: SvgPicture.asset(
                  "$image",
                  height: 50,
                  width: 50,
                )),
          ),
        ),
      ],
    );
  }
}
