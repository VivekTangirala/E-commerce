import 'package:http/http.dart' as http;

import 'Brandapi.dart';

class Brandapiimport {
  static const uri = "https://infintymall.herokuapp.com/homepage/api/brand";

  static Future<List<Brandapi>> getbrandlist() async{
    try {
      final response = await http.get(uri);
      //print(response.body);
      if (response.statusCode == 200) {
        // var data=json.decode(response.body);
        // data=da
        final List<Brandapi> categories =
            brandapiFromJson(response.body);
        return categories;
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