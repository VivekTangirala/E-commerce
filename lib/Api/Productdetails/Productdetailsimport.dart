
import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:http/http.dart' as http;

class Productdetailsimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/product";

  static Future<Productdetails> getProductdetails() async {
    try {
      final response = await http.get( "http://infintymall.herokuapp.com/homepage/api/product");
      if (response.statusCode == 200) {
        final Productdetails productdetails = productdetailsFromJson(response.body);
        return productdetails;
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