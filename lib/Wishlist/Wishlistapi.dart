// To parse this JSON data, do
//
//     final wishlistapi = wishlistapiFromJson(jsonString);

import 'dart:convert';

Wishlistapi wishlistapiFromJson(String str) => Wishlistapi.fromJson(json.decode(str));

String wishlistapiToJson(Wishlistapi data) => json.encode(data.toJson());

class Wishlistapi {
    Wishlistapi({
        this.wishList,
    });

    List<WishList> wishList;

    factory Wishlistapi.fromJson(Map<String, dynamic> json) => Wishlistapi(
        wishList: List<WishList>.from(json["WishList"].map((x) => WishList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "WishList": List<dynamic>.from(wishList.map((x) => x.toJson())),
    };
}

class WishList {
    WishList({
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

    factory WishList.fromJson(Map<String, dynamic> json) => WishList(
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
    StoreName storeName;
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
        storeName: StoreName.fromJson(json["store_name"]),
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
        "store_name": storeName.toJson(),
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
        this.id,
        this.password,
        this.email,
        this.username,
        this.phone,
        this.dateJoined,
        this.lastLogin,
        this.isAdmin,
        this.isActive,
        this.isStaff,
        this.isSuperuser,
        this.isSuperviser,
    });

    int id;
    String password;
    String email;
    String username;
    String phone;
    DateTime dateJoined;
    DateTime lastLogin;
    bool isAdmin;
    bool isActive;
    bool isStaff;
    bool isSuperuser;
    bool isSuperviser;

    factory StoreName.fromJson(Map<String, dynamic> json) => StoreName(
        id: json["id"],
        password: json["password"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        dateJoined: DateTime.parse(json["date_joined"]),
        lastLogin: DateTime.parse(json["last_login"]),
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        isStaff: json["is_staff"],
        isSuperuser: json["is_superuser"],
        isSuperviser: json["is_superviser"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "email": email,
        "username": username,
        "phone": phone,
        "date_joined": dateJoined.toIso8601String(),
        "last_login": lastLogin.toIso8601String(),
        "is_admin": isAdmin,
        "is_active": isActive,
        "is_staff": isStaff,
        "is_superuser": isSuperuser,
        "is_superviser": isSuperviser,
    };
}
