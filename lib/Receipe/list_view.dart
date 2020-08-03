import 'package:ecom/Homepage/homefragment.dart';
import 'package:ecom/Login/login.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/data.dart';
import 'details.dart';

class ReceipeView extends StatefulWidget {
  @override
  _ReceipeViewState createState() => _ReceipeViewState();
}

class _ReceipeViewState extends State<ReceipeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget body = SizedBox(
        height: 200,
        child: Container(
          color: Colors.white,
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: Data.recipes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      receipe: Data.recipes[index],
                                    )));
                      },
                      child: SizedBox(
                          child: Container(
                        margin: EdgeInsets.only(left: 4, bottom: 3),
                        width: 200,
                        decoration: BoxDecoration(
                          // border: Border.all(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(
                                  20.0) //         <--- border radius here
                              ),
                        ),
                        child: Card(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    child: Hero(
                                      tag: Data.recipes[index].id,
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            Data.recipes[index].imageUrl),
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            'assets/images/loading.gif'),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    Data.recipes[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))),
                );
              }),
        ));

    return Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recipe",
                style: Theme.of(context).textTheme.headline3,
              )),
          actions: <Widget>[
            IconButton(
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
              padding: EdgeInsets.only(left: 10, right: 15),
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Explore",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text("View More",style: Theme.of(context).textTheme.bodyText2,)
              ],
            ),
          ),
          body
        ]));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
