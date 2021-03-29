// To parse this JSON data, do
//
//     final pastordersapi = pastordersapiFromJson(jsonString);

import 'dart:convert';

Pastordersapi pastordersapiFromJson(String str) => Pastordersapi.fromJson(json.decode(str));

String pastordersapiToJson(Pastordersapi data) => json.encode(data.toJson());

class Pastordersapi {
    Pastordersapi({
        this.orders,
    });

    List<Order> orders;

    factory Pastordersapi.fromJson(Map<String, dynamic> json) => Pastordersapi(
        orders: List<Order>.from(json["Orders"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.product,
        this.createdAt,
        this.updatedAt,
        this.quantity,
        this.productCancelled,
        this.productDelivered,
    });

    Product product;
    DateTime createdAt;
    DateTime updatedAt;
    int quantity;
    bool productCancelled;
    bool productDelivered;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        product: Product.fromJson(json["product"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        quantity: json["quantity"],
        productCancelled: json["product_cancelled"],
        productDelivered: json["product_delivered"],
    );

    Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "quantity": quantity,
        "product_cancelled": productCancelled,
        "product_delivered": productDelivered,
    };
}

class Product {
    Product({
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
        this.storeName,
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
    Category category;
    dynamic storeName;
    Brand brand;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        availableInventory: json["available_inventory"],
        quantity: json["quantity"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        offerPrice: json["offer_price"],
        discountPercentage: json["discount_percentage"],
        available: json["available"],
        soldTimes: json["sold_times"],
        category: Category.fromJson(json["category"]),
        storeName: json["store_name"],
        brand: Brand.fromJson(json["brand"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available_inventory": availableInventory,
        "quantity": quantity,
        "price": price,
        "image": image,
        "description": description,
        "offer_price": offerPrice,
        "discount_percentage": discountPercentage,
        "available": available,
        "sold_times": soldTimes,
        "category": category.toJson(),
        "store_name": storeName,
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
