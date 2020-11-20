<<<<<<< HEAD
import 'package:ecom/Homepage/Brand/Brandapi.dart';
import 'package:ecom/Homepage/Brand/Brandapiimport.dart';

=======
import 'package:ecom/Api/Brandapi/Brandapi.dart';
import 'package:ecom/Api/Brandapi/Brandapiimport.dart';
>>>>>>> f4e9a7327960e73e42f2a68ecf42365414ebb9de
import 'package:flutter/material.dart';


class Brand extends StatefulWidget {
  @override
  Brandstate createState() => Brandstate();
}

class Brandstate extends State<Brand> {
  List<Brandapi> _brandapi;

  @override
  void initState() {
    super.initState();
    refreshbrand();
  }

  refreshbrand() {
    Brandapiimport.getbrandlist().then(
      (value) => setState(
        () {
          _brandapi = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110.0,
      child: _brandapi != null
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: _brandapi.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, bottom: 3),
                    child: SizedBox(
                      // height: 100,
                      width: 100,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                            child: FadeInImage(
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Container(
                                    decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/images/drinks.jpg"),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ), // set rounded corner radius
                                ));
                              },
                              placeholder:
                                  AssetImage('assets/images/loading.gif'),
                              image: NetworkImage(_brandapi[index].img),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 0.0),
                          Text(
                            _brandapi[index].name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  onTap: () {},
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
