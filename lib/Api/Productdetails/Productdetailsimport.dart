import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:http/http.dart' as http;

class Productdetailsimport {
  static Future<Productdetails> getProductdetails(List products) async {
    String uri = "https://infintymall.herokuapp.com/homepage/api/product/?ids=";
    print(uri);
    if (products.length > 0) {
      for (var i = 0; i < products.length; i++) {
        if (i == 0) {
          uri = uri + products[i].toString();
        } else {
          uri = uri + "," + products[i].toString();
        }
      }
    }

    print(uri);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Productdetails productdetails =
            productdetailsFromJson(response.body);
        print(response.body);
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
