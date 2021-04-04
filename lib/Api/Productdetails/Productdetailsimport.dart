import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:http/http.dart' as http;

class Productdetailsimport {
  static Future<Productdetails> getProductdetails(List products) async {
    String uri = "https://infintymall.herokuapp.com/vendor/api/product/?ids=";

    if (products.length > 0) {
      for (var i = 0; i < products.length; i++) {
        if (i == 0) {
          uri = uri + products[i].toString();
        } else {
          uri = uri + "," + products[i].toString();
        }
      }
    }

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Productdetails productdetails =
            productdetailsFromJson(response.body);

        return productdetails;
      } else {
        print("error in productdetailapi");

        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
