import 'package:ecom/Login/Forgotpass/phonenumber/phoneForm.dart';
import 'package:ecom/Login/components/noaccount.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatelessWidget {
  final value;

  const PhoneNumber({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        
                  Text(
                  value==1?  "Forgot Password":"Phone Number",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "One time password will be sent to the \nprovided phone number",
                    
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  PhoneForm(value: value),
                value==1?  NoAccountText():Container(),
                ],
              ),
            ),
          ),
        ));
  }
}
