
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<IconData> icons = [
  EvaIcons.messageSquareOutline,
  EvaIcons.peopleOutline,
  EvaIcons.peopleOutline,
  EvaIcons.lock,
];
List<String> l1 = ["Orders", "Rate us", "Contack us?", "Change password"];

class ProfileFirst extends StatefulWidget {
  ProfileFirst({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfileFirstState createState() => _ProfileFirstState();
}

class _ProfileFirstState extends State<ProfileFirst> {
  SharedPreferences sharedPreferences;
  String name;
  getName() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = (sharedPreferences.getString('name') ?? null);
    });
  }

  void initState() {
    super.initState();
    getName();
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    //var width = screenSize.width;
    var height = screenSize.height;

    return Scaffold(
        backgroundColor: Color(0xffF8F8FA),
        appBar: AppBar(
          backgroundColor: Colors.grey,
          elevation: 0,
        ),
        body: Stack( children: <Widget>[
          Container(
            color: Colors.grey,
            height: height / 4,
            child: Padding(
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              width: 220,
                              child: Text(
                                name != null ? "Hello, $name" : "Hello, Amigo",
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: GoogleFonts.dMSans(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(EvaIcons.arrowIosDownward),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "@instagram",
                                style: GoogleFonts.dMSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                      // Flexible(child: SizedBox(width: 10,)),
                      Flexible(
                        child: CircleAvatar(
                          minRadius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            'assets/images/drinks.jpg',
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: height / 4.8),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                           
                          },
                          child: properties(l1[index], icons[index], 1),
                        );
                      })
                  // ListView(
                  //   children: <Widget>[
                  //     SizedBox(height: 10),
                  //     properties("Edit profile", EvaIcons.messageSquareOutlineEvaIcons.peopleOutline,EvaIcons.peopleOutline,, EvaIcons.lock 1),
                  //     properties("Invite friends", EvaIcons.peopleOutline, 2),
                  //     properties(
                  //         "Give us feedback", EvaIcons.messageSquareOutline, 3),properties(
                  //         "Change password", EvaIcons.lock, 3)
                  //   ],
                  // ),
                  ))
        ]));
  }

  Widget properties(String name, IconData icon, int a) {
    return ListView(primary: false, shrinkWrap: true, children: <Widget>[
      Center(
          child: Container(
        height: 50,
        margin: EdgeInsets.only(left: 18),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 16, right: 16),
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            name,
            style: GoogleFonts.dMSans(
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          trailing: Icon(EvaIcons.arrowForwardOutline),
          onTap: () {
            // if (a == 2) {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => CustomToolTip()));
            //}
          },
        ),
      )),
      Divider(
        endIndent: 30,
        color: Colors.grey[600],
        indent: 30,
      )
    ]);
  }
}
