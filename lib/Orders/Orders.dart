import 'package:ecom/Api/Productdetails/Productdetails.dart';
import 'package:ecom/Api/Productdetails/Productdetailsimport.dart';
import 'package:ecom/Orders/Ordersapiimport.dart';
import 'package:ecom/Orders/ordersapi.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Ordersapi> _orderdetails;
  Productdetails _productdetails;
  List<String> _productids = [];
  @override
  void initState() {
    getorders();
    super.initState();
  }

  getorders() async {
    await Ordersapiimport.getorderdetails().then(
      (value) => setState(
        () {
          _orderdetails = value;
        },
      ),
    );
    for (var i = 0; i < _orderdetails.length; i++) {

      _productids.add(_orderdetails[i].product.toString());
    
    }
    print(_productids);
    await Productdetailsimport.getProductdetails(_productids).then(
      (value) => setState(
        () {
          _productdetails = value;
        },
      ),
    );
 
      
    // }
    // print(_repeatedproduteids);
    // await Productdetailsimport.getProductdetails(_productids).then(
    //   (value) => setState(
    //     () {
    //       _productdetails = value;
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: _orderdetails.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          _productdetails.results[index].image,
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        //
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_productdetails.results[index].name.toString()),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Colors.white,
    elevation: 0.0,
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        }),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
            alignment: Alignment.centerRight,
            child: Center(
              child: Text(
                "Orders",
                style: Theme.of(context).textTheme.headline3,
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 20),
              icon: Icon(
                EvaIcons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchBar());
              },
            ),
            IconButton(
              icon: Icon(
                EvaIcons.shoppingCartOutline,
                color: Colors.black,
              ),
              padding: EdgeInsets.only(left: 20),
              onPressed: () async {},
            ),
          ],
        ),
      ],
    ),
  );
}

class SearchBar extends SearchDelegate<String> {
  final cities = ["aa"];

  final recentCities = ["aa"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: transitionAnimation,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentCities : cities;
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.near_me),
              title: Text(cities[index]),
            ),
        itemCount: suggestionList.length);
  }
}
