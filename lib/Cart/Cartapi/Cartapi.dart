// To parse this JSON data, do
//
//     final cartapi = Cartapi(jsonString);

import 'dart:convert';

Cartapi cartapiFromJson(String str) => Cartapi.fromJson(json.decode(str));

String cartapiToJson(Cartapi data) => json.encode(data.toJson());

class Cartapi {
    Cartapi({
        this.cart,
    });

    List<Cart> cart;

    factory Cartapi.fromJson(Map<String, dynamic> json) => Cartapi(
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
    };
}

class Cart {
    Cart({
        this.id,
        this.userId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.quantity,
    });

    int id;
    int userId;
    int productId;
    DateTime createdAt;
    DateTime updatedAt;
    int quantity;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "quantity": quantity,
    };
}
