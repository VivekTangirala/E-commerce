import 'dart:io';

import 'package:ecom/Cart/Cartapi/Cartapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartApiimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/cart/";

  static Future<Cartapi> getUsers() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   String token = (sharedPreferences.getString('token') ?? null);
    try {
      final response = await http.get(uri,headers: {HttpHeaders.authorizationHeader:token});
      //print(response.body);
      if (response.statusCode == 200) {
        // var data=json.decode(response.body);
        // data=da
        final Cartapi cartapi = cartapiFromJson(response.body);

        return cartapi;
      } else {
        print("error");
        return null;
      }
    } catch (e) {
      print(e);

      return null;
    }
  }
}
