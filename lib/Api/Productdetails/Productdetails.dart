// To parse this JSON data, do
//
//     final productdetails = productdetailsFromJson(jsonString);

import 'dart:convert';

List<Productdetails> productdetailsFromJson(String str) => List<Productdetails>.from(json.decode(str).map((x) => Productdetails.fromJson(x)));

String productdetailsToJson(List<Productdetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Productdetails {
    Productdetails({
        this.id,
        this.storeName,
        this.name,
        this.availableInventory,
        this.quantity,
        this.price,
        this.image,
        this.description,
        this.maxUnits,
        this.offerPrice,
        this.discountPercentage,
        this.available,
        this.soldTimes,
        this.category,
        this.brand,
    });

    int id;
    StoreName storeName;
    String name;
    int availableInventory;
    String quantity;
    int price;
    String image;
    String description;
    int maxUnits;
    int offerPrice;
    int discountPercentage;
    bool available;
    int soldTimes;
    Category category;
    Brand brand;

    factory Productdetails.fromJson(Map<String, dynamic> json) => Productdetails(
        id: json["id"],
        storeName: StoreName.fromJson(json["store_name"]),
        name: json["name"],
        availableInventory: json["available_inventory"],
        quantity: json["quantity"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        maxUnits: json["max_units"],
        offerPrice: json["offer_price"],
        discountPercentage: json["discount_percentage"],
        available: json["available"],
        soldTimes: json["sold_times"],
        category: Category.fromJson(json["category"]),
        brand: Brand.fromJson(json["brand"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_name": storeName.toJson(),
        "name": name,
        "available_inventory": availableInventory,
        "quantity": quantity,
        "price": price,
        "image": image,
        "description": description,
        "max_units": maxUnits,
        "offer_price": offerPrice,
        "discount_percentage": discountPercentage,
        "available": available,
        "sold_times": soldTimes,
        "category": category.toJson(),
        "brand": brand.toJson(),
    };
}

class Brand {
    Brand({
        this.id,
        this.name,
        this.img,
    });

    int id;
    String name;
    String img;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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

class Category {
    Category({
        this.id,
        this.name,
        this.image,
    });

    int id;
    String name;
    String image;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}

class StoreName {
    StoreName({
        this.username,
    });

    String username;

    factory StoreName.fromJson(Map<String, dynamic> json) => StoreName(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}
