import 'package:ecom/Homepage/Branditems/Branditems.dart';
import 'package:http/http.dart' as http;

import 'Branditemsapi.dart';

class Branditemimport {
  static Future<List<Branditemsapi>> getbranditems(String s) async {
    String uri =
        "http://infintymall.herokuapp.com/vendor/api/product/?brand__name=";
    uri = uri + s;
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<Branditemsapi> branditems =
            branditemsapiFromJson(response.body);
        return branditems;
      } else {
        print("error in brand items api");
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
