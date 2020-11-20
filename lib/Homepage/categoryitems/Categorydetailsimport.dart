import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:http/http.dart' as http;
import 'Categorydetailsapi.dart';

class Categorydetailsimport {
  static Future<Categorydetails> getcategorydetails(String s) async {
    String uri =
        "http://infintymall.herokuapp.com/homepage/api/product/?category__name=";
    uri = uri + s;
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Categorydetails categorydetails =
            categorydetailsFromJson(response.body);
        print("working");
        print(categorydetails.results[0].brand);
        return categorydetails;
      } else {
        print("error");
        print(response.statusCode);
        print(response.body);
        return null;
      }
    } catch (e) {
      print("error");
      return null;
    }
  }
}
