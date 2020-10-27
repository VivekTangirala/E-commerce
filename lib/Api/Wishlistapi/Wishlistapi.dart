// To parse this JSON data, do
//
//     final wishlistapi = wishlistapiFromJson(jsonString);

import 'dart:convert';

Wishlistapi wishlistapiFromJson(String str) => Wishlistapi.fromJson(json.decode(str));

String wishlistapiToJson(Wishlistapi data) => json.encode(data.toJson());

class Wishlistapi {
    Wishlistapi({
        this.wishlist,
    });

    List<Wishlist> wishlist;

    factory Wishlistapi.fromJson(Map<String, dynamic> json) => Wishlistapi(
        wishlist: List<Wishlist>.from(json["wishlist"].map((x) => Wishlist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "wishlist": List<dynamic>.from(wishlist.map((x) => x.toJson())),
    };
}

class Wishlist {
    Wishlist({
        this.id,
        this.userId,
        this.productId,
    });

    int id;
    int userId;
    int productId;

    factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
    };
}
