import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:http/http.dart' as http;

class Productdetailsimport {
  static Future<Productdetails> getProductdetails(List l) async {
    String uri = "http://infintymall.herokuapp.com/homepage/api/product/?ids=";
    String s = "";
    if (l.length > 0) {
      for (var i = 0; i < l.length; i++) {
        if (i == 0) {
          s = l[i];
        } else {
          s = s + "," + l[i];
        }
      }
    }
    uri = uri + s;
    print(uri);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Productdetails productdetails =
            productdetailsFromJson(response.body);
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
