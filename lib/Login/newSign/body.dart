import 'package:ecom/Login/newSign/noaccount.dart';
import 'package:ecom/Login/newSign/screensize.dart';
import 'package:ecom/Login/newSign/form.dart';
import 'package:ecom/bottom_nav.dart';
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
                SizedBox(height: SizeConfig.screenHeight * 0.07),
                
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),
                Text(
                  "Sign in with your phone and password \nto continue ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),  
                SizedBox(height: getProportionateScreenHeight(30)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
