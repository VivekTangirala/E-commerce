import 'package:http/http.dart' as http;

import 'Discoverdata.dart';

class Discoverimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/product";

  static Future<Discoverdata> getUsers() async {
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Discoverdata discover = discoverdataFromJson(response.body);
        return discover;
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
