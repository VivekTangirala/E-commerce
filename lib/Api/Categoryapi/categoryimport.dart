import 'package:http/http.dart' as http;

import 'categorydata.dart';

class Categoryimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/category";

  static Future<List<Categorydata>> getUsers() async {
    try {
      final response = await http.get(uri);
      //print(response.body);
      if (response.statusCode == 200) {
        // var data=json.decode(response.body);
        // data=da
        final List<Categorydata> categories =
            categorydataFromJson(response.body);
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
