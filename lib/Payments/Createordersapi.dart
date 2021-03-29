import 'dart:convert';

Createorderapi createorderapiFromJson(String str) => Createorderapi.fromJson(json.decode(str));

String createorderapiToJson(Createorderapi data) => json.encode(data.toJson());

class Createorderapi {
    Createorderapi({
        this.orders,
    });

    Orders orders;

    factory Createorderapi.fromJson(Map<String, dynamic> json) => Createorderapi(
        orders: Orders.fromJson(json["orders"]),
    );

    Map<String, dynamic> toJson() => {
        "orders": orders.toJson(),
    };
}

class Orders {
    Orders({
        this.id,
        this.entity,
        this.amount,
        this.amountPaid,
        this.amountDue,
        this.currency,
        this.receipt,
        this.offerId,
        this.status,
        this.attempts,
        this.notes,
        this.createdAt,
    });

    String id;
    String entity;
    int amount;
    int amountPaid;
    int amountDue;
    String currency;
    dynamic receipt;
    dynamic offerId;
    String status;
    int attempts;
    List<dynamic> notes;
    int createdAt;

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["id"],
        entity: json["entity"],
        amount: json["amount"],
        amountPaid: json["amount_paid"],
        amountDue: json["amount_due"],
        currency: json["currency"],
        receipt: json["receipt"],
        offerId: json["offer_id"],
        status: json["status"],
        attempts: json["attempts"],
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "amount": amount,
        "amount_paid": amountPaid,
        "amount_due": amountDue,
        "currency": currency,
        "receipt": receipt,
        "offer_id": offerId,
        "status": status,
        "attempts": attempts,
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "created_at": createdAt,
    };
}
