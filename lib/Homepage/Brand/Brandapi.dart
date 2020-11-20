// To parse this JSON data, do
//
//     final brandapi = brandapiFromJson(jsonString);

import 'dart:convert';

List<Brandapi> brandapiFromJson(String str) => List<Brandapi>.from(json.decode(str).map((x) => Brandapi.fromJson(x)));

String brandapiToJson(List<Brandapi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brandapi {
    Brandapi({
        this.id,
        this.name,
        this.img,
    });

    int id;
    String name;
    String img;

    factory Brandapi.fromJson(Map<String, dynamic> json) => Brandapi(
        id: json["id"],
        name: json["name"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
    };
}
