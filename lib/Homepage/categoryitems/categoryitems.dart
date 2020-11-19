import 'package:ecom/Api/Categorydetailsapi/Categorydetailsapi.dart';
import 'package:ecom/Api/Categorydetailsapi/Categorydetailsimport.dart';
import 'package:ecom/components/appBar.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';




class Categoryitems extends StatefulWidget {
  final String string;

  const Categoryitems({Key key, this.string}) : super(key: key);
  @override
  Categoryitemsstate createState() => Categoryitemsstate(string);
}

class Categoryitemsstate extends State<Categoryitems> {
  final String _string;
  Categorydetails _categorydetails;

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
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: _categorydetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    //padding: EdgeInsets.only(right: 15.0),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 25.0),
                    itemCount: _categorydetails.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Column(children: [
                          SizedBox(
                            height: getProportionateScreenHeight(52),
                            width: getProportionateScreenWidth(25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Image.network(
                                  _categorydetails.results[index].image),
                            ),
                          ),
                          Text(
                            _categorydetails.results[index].name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ]),
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
