import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';
import 'package:ecom/components/Search/Searchapi.dart';
import 'package:ecom/components/Search/Searchapiimport.dart';
import 'package:ecom/components/screensize.dart';
import 'package:flutter/material.dart';

List _history = ["Example1", "example2"];
List apiresults = ["Example3", "Example1", "example2"];
List<Searchapi> _searchresults;

class SearchBAr extends StatefulWidget {
  @override
  _SearchBArState createState() => _SearchBArState();
}

class _SearchBArState extends State<SearchBAr> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  searchdetails(_search) async {
    await Searchimport.getsearchresults(_search).then((value) => setState(() {
          _searchresults = value;
          print("In searchdetails function");
          print(value);
        }));
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _textEditingController,
                    onTap: () {
                      return ListView(
                        children: [ListTile(title: Text("hello"))],
                      );
                      // showSearch(context: context, delegate: SearchBar());
                      // FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onChanged: (String txt) {
                      return null;
                    },
                    onSubmitted: (String txt) {},
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
                  showSearch(
                      context: context, delegate: SearchBar(searchdetails));

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
}

class SearchBar extends SearchDelegate<String> {
  final func;
  void _search(String _str) async {
    await func(_str);
    print("In search fnction");
  }

  SearchBar(this.func);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
    //actions for appbar in the end
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icons on the left side
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
    //show some result
    _search(query.toString());
    return Container(
      child: _searchresults == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _searchresults.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(_searchresults[index].name),
                );
              }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //shows suggestions
    if (query.isEmpty == false) {
      // _searchresults(query);
    }
    List suggestions = query.isEmpty ? _history : apiresults;
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: Icon(Icons.history),
            title: Text(suggestions[index]),
          );
        });
  }
}
