import 'dart:io';

import 'package:ecom/Orders/ordersapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Ordersapiimport {
  static Future<Pastordersapi> getorderdetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    String uri = "http://infintymall.herokuapp.com/homepage/api/order";
    try {
      final response = await http
          .get(uri, headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        final Pastordersapi orderapi = pastordersapiFromJson(response.body);
        return orderapi;
      } else {
        print("error in ordersapi:status code=");
        print(response.statusCode);
        return null;
      }
      
    } catch (e) {
      print("Caught exception e:");
      print(e);
    }
    return null;
  }
}
