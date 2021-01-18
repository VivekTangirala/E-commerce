import 'dart:io';

import 'package:ecom/Wishlist/Wishlistapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Wishlistapiimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/wishlist/";

  static Future<Wishlistapi> getwishlist() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token = sharedPreferences.getString("token");

    try {
      final response = await http.get(
          "https://infintymall.herokuapp.com/homepage/api/wishlist",
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        final Wishlistapi wishlistapi = wishlistapiFromJson(response.body);
        // print(wishlistapi);
        return wishlistapi;
      } else {
        print("error");
        return null;
      }
    } on SocketException {} catch (e) {
      print(e);
      return null;
    }
    return null;
  }
}
