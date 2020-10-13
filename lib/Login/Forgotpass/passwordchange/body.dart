import 'package:ecom/Login/Forgotpass/passwordchange/passwordform.dart';
import 'package:ecom/Login/components/constants.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
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
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.001),
                  // 4%
                Text("Change Password", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.006),
                Text(
                  "Continue to change to \nyour password",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.1),  
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
