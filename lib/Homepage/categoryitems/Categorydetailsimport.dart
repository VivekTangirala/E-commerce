import 'package:http/http.dart' as http;
import 'Categorydetailsapi.dart';

class Categorydetailsimport {
  static Future<List<Categorydetails>> getcategorydetails(String s) async {
    String uri =
        "http://infintymall.herokuapp.com/vendor/api/product/?category__name=";
    uri = uri + s;
    print(uri);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<Categorydetails> categorydetails =
            categorydetailsFromJson(response.body);
        print("working");
        return categorydetails;
      } else {
        print("error");
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
