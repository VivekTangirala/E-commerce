import 'dart:io';

import 'package:ecom/Cart/Cartapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartApiimport {
  static const uri = "https://infintymall.herokuapp.com/homepage/api/cart";

  static Future<Cartapi> getCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String token = sharedPreferences.getString("token");

    try {
      //print(response.body);
      final response = await http.get(
          uri,
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        final Cartapi cartapi = cartapiFromJson(response.body);

        return cartapi;
      } else {
        print("error in cartapi");
        return null;
      }
    } on SocketException {} catch (e) {
      print(e);

      return null;
    }
    return null;
  }
}
