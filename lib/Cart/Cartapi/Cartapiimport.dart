import 'package:ecom/Cart/Cartapi/Cartapi.dart';
import 'package:http/http.dart' as http;

class CartApiimport {
  static const uri = "http://infintymall.herokuapp.com/homepage/api/cart/";

  static Future<Cartapi> getUsers() async {
    try {
      final response = await http.get(uri);
      //print(response.body);
      if (response.statusCode == 200) {
        // var data=json.decode(response.body);
        // data=da
        final Cartapi cartapi = cartapiFromJson(response.body);

        return cartapi;
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
