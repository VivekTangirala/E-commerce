import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Cartapiremove {
  static Future<Cartapiremove> removefromcart(String _productid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    print(token);
    final baseurl = "https://infintymall.herokuapp.com/homepage/api/cart";
    final url = Uri.parse(baseurl);
    final request = http.Request("DELETE", url);
    request.headers.addAll(<String, String>{
      HttpHeaders.authorizationHeader: token,  
    });
    request.body = jsonEncode({"product": _productid.toString()});
    final response = await request.send();
    try {
      // final response = await http
      //     .delete("http://infintymall.herokuapp.com/homepage/api/cart",
      //         // body:data,
      //         headers: {HttpHeaders.authorizationHeader: _token});
      if (response.statusCode == 200) {
        print("product removed");
      } else {
        print(response.statusCode);
        print(request.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
