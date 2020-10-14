
import 'package:http/http.dart' as http;

import 'Productapi.dart';
class Productapiimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/product";

  static Future<Productsapi> getProducts() async {
    try {
      final response = await http.get( "http://infintymall.herokuapp.com/homepage/api/product");
      if (response.statusCode == 200) {
        final Productsapi productsapi = productsapiFromJson(response.body);
        return productsapi;
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