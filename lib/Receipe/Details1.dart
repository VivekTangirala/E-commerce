import 'package:ecom/Receipe/Directions.dart';
import 'package:flutter/material.dart';


List<String> l1 = [
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  "assets/images/burger.jpeg",
];
List<String> l2 = [
  "Tomatoes",
  "Onions",
  "Burger",
];
List<String> l3 = [
  "10 pieces",
  "15 pieces",
  "50 slices",
];

class Details1 extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<Details1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              pinned: false,
              title: Text("Item Name"),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: ' recipe.id',
                  child:Container()
                  //  FadeInImage(
                  //   image: NetworkImage(recipe.imageUrl),
                  //   fit: BoxFit.cover,
                  //   placeholder: AssetImage('assets/images/loading.gif'),
                  // ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  'Nutrition',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ingredients',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(letterSpacing: 1),
                    ),
                    InkWell(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         RecipeSteps()));
                        },
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RecipeSteps(
                                          steps: l2,
                                        )));
                              },
                              child: Text(
                                'View Directions',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Container(
                              child: Text("                              "),
                              height: 4.0,
                              decoration:
                                  BoxDecoration(color: Colors.orangeAccent),
                            )
                          ],
                        ))
                  ],
                ),
                // Text('Steps',
                //     style: Theme.of(context).textTheme.headline2,),
                // RecipeSteps(
                //   steps: recipe.steps,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
