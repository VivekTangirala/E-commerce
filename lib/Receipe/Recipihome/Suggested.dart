import 'package:flutter/material.dart';

List<String> list = ["Burger", "Cherry", "Orange", "Apple"];
List<String> list1 = ["A salad between 2 breads", "50", "45", "55"];
List<String> list3 = ["4.5", "5", "4", "2.5"];
final List<String> images = [
  "assets/images/burger.jpeg",
  "assets/images/tomato.png",
  "assets/images/onion.jpeg",
  'assets/images/some.jpg',
];

class Suggested extends StatefulWidget {
  @override
  Suggestedstate createState() => Suggestedstate();
}

class Suggestedstate extends State<Suggested> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
    height: MediaQuery.of(context).size.height/3.5,
      child: ListView.builder(
        padding: EdgeInsets.only(right:15.0),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 4, bottom: 3,right:5.0),
               width: 300,
              // decoration: BoxDecoration(
              //   // border: Border.all(width: 1.0),
              //   borderRadius: BorderRadius.all(
              //       Radius.circular(20.0) //         <--- border radius here
              //       ),
              // ),
           
                  // color: Colors.grey[200],
                  // shape: RoundedRectangleBorder(
                  //   side: BorderSide(color: Colors.white70, width: 1),
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: Column(children: [
                    SizedBox(
                  height: MediaQuery.of(context).size.height/5,
                      child: Container(
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(images[index])),
                          color: Colors.white,
                          // border: Border.all(
                          //     color: Colors.black12, // set border color
                          //     width: 0.6), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0)), // set rounded corner radius
                        ),
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                      Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index],
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            list1[index],
                            style: Theme.of(context).textTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Text(
                        list3[index],
                        style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                      ),
                    ])
                  ]),
                
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
