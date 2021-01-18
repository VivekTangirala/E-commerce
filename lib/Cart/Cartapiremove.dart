import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Cartapiremove {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/cart";
  static Future<Cartapiremove> removefromcart(String _productid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _token = sharedPreferences.getString("token");
    final baseurl = "http://infintymall.herokuapp.com/homepage/api/cart";
    final url = Uri.parse(baseurl);
    Map data = {'product': _productid.toString()};
    final request = http.Request("DELETE", url);
    request.headers.addAll(<String, String>{
      HttpHeaders.authorizationHeader: _token,
      
    });
    request.body = jsonEncode({"product": _productid.toString()});
    final response = await request.send();
    try {
      // final response = await http
      //     .delete("http://infintymall.herokuapp.com/homepage/api/cart",
      //         // body:data,
      //         headers: {HttpHeaders.authorizationHeader: _token});
      print(request.body);
      if (response.statusCode == 200) {
        print("product removed");
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
