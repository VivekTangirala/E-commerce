import 'package:ecom/Login/components/constants.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';

import 'signupform.dart';

class Body extends StatelessWidget {
  final  phone;

  const Body({Key key, this.phone}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Getting Started", style: headingStyle),
                Text(
                  "Enter details to create an account",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SignUpForm(
                  phone:phone
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Text(
                  'By continuing, you confirm that you agree \nwith our Terms and Conditions',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
