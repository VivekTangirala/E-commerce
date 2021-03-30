import 'package:ecom/Payments/Createordersapi.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Createordersimport {
 static Future<Createorderapi> getorderdetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token = sharedPreferences.getString('token');

    String uri = "http://infintymall.herokuapp.com/homepage/api/order";

    try {
      var response = await http
          .post(uri, headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        final Createorderapi createorderapi =
            createorderapiFromJson(response.body);
        return createorderapi;
      } else {
        print("error");
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
