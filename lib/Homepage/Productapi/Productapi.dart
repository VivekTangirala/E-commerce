// To parse this JSON data, do
//
//     final productsapi = productsapiFromJson(jsonString);

import 'dart:convert';

Productsapi productsapiFromJson(String str) => Productsapi.fromJson(json.decode(str));

String productsapiToJson(Productsapi data) => json.encode(data.toJson());

class Productsapi {
    Productsapi({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    factory Productsapi.fromJson(Map<String, dynamic> json) => Productsapi(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.name,
        this.availableInventory,
        this.quantity,
        this.price,
        this.image,
        this.description,
        this.offerPrice,
        this.discountPercentage,
        this.available,
        this.soldTimes,
        this.category,
        this.brand,
    });

    int id;
    String name;
    int availableInventory;
    String quantity;
    int price;
    String image;
    String description;
    int offerPrice;
    int discountPercentage;
    bool available;
    int soldTimes;
    int category;
    int brand;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        availableInventory: json["available_inventory"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        offerPrice: json["offer_price"],
        discountPercentage: json["discount_percentage"],
        available: json["available"],
        soldTimes: json["sold_times"],
        category: json["category"],
        brand: json["brand"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available_inventory": availableInventory,
        "quantity": quantity == null ? null : quantity,
        "price": price,
        "image": image,
        "description": description,
        "offer_price": offerPrice,
        "discount_percentage": discountPercentage,
        "available": available,
        "sold_times": soldTimes,
        "category": category,
        "brand": brand,
    };
}
