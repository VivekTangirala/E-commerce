import 'package:ecom/Cart/cart.dart';
import 'package:ecom/Homepage/categoryitems/Categorydetailsapi.dart';
import 'package:ecom/Homepage/categoryitems/Categorydetailsimport.dart';
import 'package:ecom/Wishlist/Wishlist.dart';
import 'package:ecom/components/appBar.dart';
import 'package:ecom/components/screensize.dart';
import 'package:ecom/productDetails/details_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Categoryitems extends StatefulWidget {
  final String string;

  const Categoryitems({Key key, this.string}) : super(key: key);
  @override
  Categoryitemsstate createState() => Categoryitemsstate(string);
}

class Categoryitemsstate extends State<Categoryitems> {
  final String _string;
  List<Categorydetails> _categorydetails;

  Categoryitemsstate(this._string);

  @override
  void initState() {
    super.initState();
    getcategorydetails1();
  }

  getcategorydetails1() async {
    await Categorydetailsimport.getcategorydetails(_string)
        .then((value) => setState(() {
              _categorydetails = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      backgroundColor: Colors.white,
      // appBar: appBar(context,),
      body: _categorydetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8.0),
                        vertical: getProportionateScreenHeight(5.0)),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _categorydetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: getProportionateScreenHeight(165.0),
                                    width: getProportionateScreenWidth(130.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(5.0),
                                        vertical:
                                            getProportionateScreenHeight(5.0),
                                      ),
                                      child: FadeInImage(
                                        imageErrorBuilder:
                                            (BuildContext context,
                                                Object exception,
                                                StackTrace stackTrace) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/images/drinks.jpg"),
                                              ),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ), // set rounded corner radius
                                            ),
                                          );
                                        },
                                        placeholder: AssetImage(
                                            'assets/images/loading.gif'),
                                        image: NetworkImage(
                                            _categorydetails[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                      //alignment: Alignment.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(30.0),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _categorydetails[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(2.0),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "₹ " +
                                                _categorydetails[index]
                                                    .offerPrice
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption.copyWith(color:Colors.red),
                                          ),
                                          SizedBox(
                                            width: getProportionateScreenWidth(
                                                4.0),
                                          ),
                                          Text(
                                              _categorydetails[index]
                                                  .price
                                                  .toString(),
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(2.0),
                                      ),
                                      Text(
                                        _categorydetails[index]
                                                .discountPercentage
                                                .toString() +
                                            "% OFF",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      Text(
                                        "Save ₹" +
                                            (_categorydetails[index].price -
                                                    _categorydetails[index]
                                                        .offerPrice)
                                                .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => DetailsScreen(
                                productid: _categorydetails[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Center(
        child: Text(
          _string,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.only(left: 20),
          icon: Icon(
            EvaIcons.heartOutline,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Wishlist();
                },
              ),
            );
            //  showSearch(context: context, delegate: SearchBar());
          },
        ),
        IconButton(
          icon: Icon(
            EvaIcons.shoppingCartOutline,
            color: Colors.black,
          ),
          padding: EdgeInsets.only(left: 20, right: 16),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart1()),
            );
          },
        ),
      ],
    );
  }
}
