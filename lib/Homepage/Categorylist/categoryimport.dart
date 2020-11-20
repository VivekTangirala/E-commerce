import 'package:http/http.dart' as http;

import 'categorydata.dart';

class Categoryimport {
  static const uri = "https://infintymall.herokuapp.com/homepage/api/category";

  static Future<List<Categorydata>> getCategoryList() async {
    try {
      final response = await http.get(uri);
      //print(response.body);
      if (response.statusCode == 200) {
        // var data=json.decode(response.body);
        // data=da
        final List<Categorydata> categories =
            categorydataFromJson(response.body);
            print("done");
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
