import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecom/Homepage/homefragment.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  final String id, amount, currency;

  const Checkout({Key key, this.id, this.amount, this.currency})
      : super(key: key);
  @override
  _CheckoutState createState() => _CheckoutState(id, amount, currency);
}

class _CheckoutState extends State<Checkout> {
  final String _id, _amount, _currency;
  _CheckoutState(this._id, this._amount, this._currency);
  bool _paymentsuccess;
  Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future _placeorder(String id, amount, currency) {
    var options = {
      "key": "rzp_test_yroe2TxC4cG8wf",
      "amount": amount,
      "name": "TREG",
      "description": "Transaction of $amount",
      "order_id": id,
      "prefill": {
        "name": "demo_name",
        "email": "demo@gmail.com",
        "contact": "8888888888"
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      e.toString();
    }
    return null;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        "H111111111111111111111111111111111111111111111111111111111111111111111111111");
    print(response.orderId);
    print(response.paymentId);
    print(response.signature);
    _paymentsuccess = true;
    getpaymentverification(
        response.orderId, response.paymentId, response.signature);
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _paymentsuccess = false;
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Confirm order",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Amount payable:    "),
                  Text(_amount),
                  Text(_currency),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: () async {
                    await _placeorder(_id, _amount, _currency);
                    if (null) {
                      
                    }
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HomeFragment();
                    }));
                    // if (_success || _error == true)
                    //   {
                    //     Navigator.of(context).pushAndRemoveUntil(
                    //         MaterialPageRoute(builder: (BuildContext context) {
                    //       return HomeFragment();
                    //     }), ModalRoute.withName("/")),
                    //   }
                  },
                  color: Colors.greenAccent,
                  child: Text(
                    "Placeorder",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getpaymentverification(razororderid, paymentid, signature) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token = sharedPreferences.getString('token');

    String uri = "http://infintymall.herokuapp.com/homepage/api/verifyorder";

    Map data = {
      'razorsignature': signature,
      'razororderid': razororderid,
      'razorpaymentid': paymentid
    };

    try {
      var response = await http.post(
        uri,
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      );
      if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
    }
  }
}
