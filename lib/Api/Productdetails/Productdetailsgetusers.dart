// import 'package:ecom/Api/Productdetails/Productdetails.dart';
// import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
// import 'package:ecom/Api/Specialproductsapi/Specialproductsimport.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Productdetailsgetusers extends StatefulWidget {
//   @override
//   _ProductdetailsgetusersState createState() => _ProductdetailsgetusersState();
// }

// class _ProductdetailsgetusersState extends State<Productdetailsgetusers> {
//   Productdetails _productdetails;
//   bool _isloading = true;
//   // refresh() {
//   //   Specialproductsimport.getspecialproudcts().then(
//   //     (value) => setState(
//   //       () {
//   //         _specialproducts = value;
//   //         _isloading = false;
//   //         print(_specialproducts[0].specialProducts.length);
//   //       },
//   //     ),
//   //   );
//   // }

//   refreshproductdetails(List l1) {
//     Productdetailsimport.getProductdetails(l1).then((value) => setState(() {
//           _productdetails = value;
//           _isloading = false;
//         }));
//     return _productdetails;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
// }
