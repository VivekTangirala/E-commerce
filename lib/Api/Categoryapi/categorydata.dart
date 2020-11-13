// To parse this JSON data, do
//
//     final categorydata = categorydataFromJson(jsonString);

import 'dart:convert';

List<Categorydata> categorydataFromJson(String str) => List<Categorydata>.from(json.decode(str).map((x) => Categorydata.fromJson(x)));

String categorydataToJson(List<Categorydata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categorydata {
    Categorydata({
        this.id,
        this.name,
        this.image,
    });

    int id;
    String name;
    String image;

    factory Categorydata.fromJson(Map<String, dynamic> json) => Categorydata(
        id: json["id"],
        name: json["name"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image == null ? null : image,
    };
}
