import 'dart:io';

import 'package:ecom/Api/Cartapi/Cartapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartApiimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/cart";

  static Future<Cartapi> getCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");

    try {
      //print(response.body);

      print(token);
      final response = await http.get(
          "http://infintymall.herokuapp.com/homepage/api/cart",
          headers: {HttpHeaders.authorizationHeader: token});
      print(response.body);
      if (response.statusCode == 200) {
        final Cartapi cartapi = cartapiFromJson(response.body);

        return cartapi;
      } else {
        print("error");
        return null;
      }
    }
    on SocketException{

    }
     catch (e) {
      print(e);

      return null;
    }
  }
}