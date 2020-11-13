// To parse this JSON data, do
//
//     final specialproductsapi = specialproductsapiFromJson(jsonString);

import 'dart:convert';

List<Specialproductsapi> specialproductsapiFromJson(String str) => List<Specialproductsapi>.from(json.decode(str).map((x) => Specialproductsapi.fromJson(x)));

String specialproductsapiToJson(List<Specialproductsapi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Specialproductsapi {
    Specialproductsapi({
        this.id,
        this.specialProducts,
    });

    int id;
    List<int> specialProducts;

    factory Specialproductsapi.fromJson(Map<String, dynamic> json) => Specialproductsapi(
        id: json["id"],
        specialProducts: List<int>.from(json["special_products"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "special_products": List<dynamic>.from(specialProducts.map((x) => x)),
    };
}
