import 'package:ecom/Api/Specialproductsapi/Specialproductsapi.dart';
import 'package:http/http.dart' as http;

class Specialproductsimport {
  static const uri =
      "https://infintymall.herokuapp.com/homepage/api/specialproducts";

  static Future<List<Specialproductsapi>> getspecialproudcts() async {
    try {
      final response = await http.get(uri);
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
