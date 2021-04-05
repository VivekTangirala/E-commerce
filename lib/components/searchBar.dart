
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';

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

Widget searchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.all(
                  Radius.circular(38.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: TextField(
                  onChanged: (String txt) {},
                  onSubmitted: (String txt){},
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.only(left: 16),
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(38.0),
                        ),
                        borderSide: new BorderSide(
                          color: Colors.teal,
                        )),
                    //  border: InputBorder.none,
                    hintText: 'Search...',
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: getProportionateScreenHeight(40),
          width: getProportionateScreenWidth(40),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 8.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              onTap: () {
                showSearch(context: context, delegate: SearchBar());
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Icon(Icons.search, size: 25, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}