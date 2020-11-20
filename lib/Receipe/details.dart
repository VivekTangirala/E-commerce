import 'package:flutter/material.dart';

import 'Utils/class.dart';
import 'Utils/widgets.dart';

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

class DetailsPage extends StatefulWidget {
  final Recipe receipe;

  const DetailsPage({Key key, this.receipe}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState(receipe);
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  final Recipe recipe;

  _DetailsPageState(this.recipe);

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: this,
    );
  }

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
              title: Text(recipe.title),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: recipe.id,
                  child: FadeInImage(
                    imageErrorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Container(
                          decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/drinks.jpg"),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ), // set rounded corner radius
                      ));
                    },
                    placeholder: AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(recipe.imageUrl),
                    fit: BoxFit.cover,
                  ),
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
                Itemdetails(),
                SizedBox(height: 10.0),
                Text(
                  'Nutrition',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 10.0),
                NutritionWidget(
                  nutrients: recipe.nutrients,
                ),
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
                            Text(
                              'View Directions',
                              style: Theme.of(context).textTheme.bodyText1,
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
                IngredientsWidget(
                  ingredients: recipe.ingredients,
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

class IngredientsWidget extends StatelessWidget {
  final List<String> ingredients;
  IngredientsWidget({this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: l1.length,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        l1[index],
                        height: 70.0,
                        width: 70.0,
                      ),
                      SizedBox(width: 15.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            Text(
                              l2[index],
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              l3[index],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ])
                    ],
                  ),
                  Card(
                    child: Text("Add to Cart"),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class NutritionWidget extends StatelessWidget {
  final List<Nutrients> nutrients;
  NutritionWidget({this.nutrients});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      width: double.infinity,
      child: ListView.builder(
        itemCount: nutrients.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return CircleIndicator(
            percent: nutrients[index].percent,
            nutrient: nutrients[index],
          );
        },
      ),
    );
  }
}

class Itemdetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.orangeAccent,
                        size: 40.0,
                      ),
                      Text(" 4 "),
                    ],
                  ),
                  SizedBox(width: 40.0),
                  Column(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.orangeAccent,
                        size: 40.0,
                      ),
                      Text("30 Min")
                    ],
                  ),
                  SizedBox(width: 40.0),
                  Column(
                    children: [
                      Icon(
                        Icons.directions_run,
                        color: Colors.orangeAccent,
                        size: 40.0,
                      ),
                      Text(
                        "420 Cal",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ]),
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 20.0,
            )
          ],
        ));
  }
}
