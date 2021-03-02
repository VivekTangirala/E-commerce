// To parse this JSON data, do
//
//     final ordersapi = ordersapiFromJson(jsonString);

import 'dart:convert';

List<Ordersapi> ordersapiFromJson(String str) => List<Ordersapi>.from(json.decode(str).map((x) => Ordersapi.fromJson(x)));

String ordersapiToJson(List<Ordersapi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ordersapi {
    Ordersapi({
        this.id,
        this.quantity,
        this.addedToCart,
        this.addedToWishList,
        this.productOrdered,
        this.productCancelled,
        this.createdAt,
        this.updatedAt,
        this.orderid,
        this.user,
        this.product,
        this.userAddress,
    });

    int id;
    int quantity;
    bool addedToCart;
    bool addedToWishList;
    bool productOrdered;
    bool productCancelled;
    DateTime createdAt;
    DateTime updatedAt;
    String orderid;
    int user;
    int product;
    dynamic userAddress;

    factory Ordersapi.fromJson(Map<String, dynamic> json) => Ordersapi(
        id: json["id"],
        quantity: json["quantity"],
        addedToCart: json["added_to_cart"],
        addedToWishList: json["added_to_wish_list"],
        productOrdered: json["product_ordered"],
        productCancelled: json["product_cancelled"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderid: json["orderid"],
        user: json["user"],
        product: json["product"],
        userAddress: json["user_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "added_to_cart": addedToCart,
        "added_to_wish_list": addedToWishList,
        "product_ordered": productOrdered,
        "product_cancelled": productCancelled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "orderid": orderid,
        "user": user,
        "product": product,
        "user_address": userAddress,
    };
}
