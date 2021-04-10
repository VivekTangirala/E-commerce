import 'package:ecom/components/Search/Searchapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Searchimport {
  static Future<List<Searchapi>> getsearchresults(String s) async {
    String uri = "http://infintymall.herokuapp.com/vendor/api/product/?search=";
    uri = uri + s;
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<Searchapi> searchresults = searchapiFromJson(response.body);
        return searchresults;
      } else {
        print("error in searchbar api");
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
