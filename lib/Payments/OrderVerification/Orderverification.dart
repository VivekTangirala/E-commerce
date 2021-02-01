// // To parse this JSON data, do
// //
// //     final orderverification = orderverificationFromJson(jsonString);

// import 'dart:convert';

// Orderverification orderverificationFromJson(String str) => Orderverification.fromJson(json.decode(str));

// String orderverificationToJson(Orderverification data) => json.encode(data.toJson());

// class Orderverification {
//     Orderverification({
//         this.detail,
//     });

//     String detail;

//     factory Orderverification.fromJson(Map<String, dynamic> json) => Orderverification(
//         detail: json["detail"],
//     );

//     Map<String, dynamic> toJson() => {
//         "detail": detail,
//     };
// }
