import 'package:ecom/Api/Specialproductsapi/Specialproductsapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Specialproductsimport {
  static const uri =
      "http://infintymall.herokuapp.com/homepage/api/specialproducts";

  static Future<List<Specialproductsapi>> getspecialproudcts() async {
    try {
      final response = await http.get(uri);
      //print(response.body);
      if (response.statusCode == 200) {
        final List<Specialproductsapi> specialproducts =
            specialproductsapiFromJson(response.body);

        return specialproducts;
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
