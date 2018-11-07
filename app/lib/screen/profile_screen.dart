import 'package:flutter/material.dart';

// /**
//  * Importing icons from Font Awesome
//  */
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// /**
//  * Importing Modules for Firebase
//  */
import 'package:firebase_auth/firebase_auth.dart';

// /**
//  * Importing Google Modules
//  */
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_database/firebase_database.dart';

DatabaseReference database = FirebaseDatabase.instance.reference();

//  * Importing the Barcode Scan Module
//  * * REFER TO DOCUMENTATION
//  * * - https://pub.dartlang.org/packages/barcode_scan#-readme-tab-
//  */
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';

// /**
//  * Importing dart libraries
//  * - dart:async
//  *    - handles promises function
//  *    - also needs to store http requests and responses
//  */
// import 'dart:async';

final GoogleSignIn _googleSignIn = GoogleSignIn();

// /**
//  * EXTERNAL METHODS
//  */
googleLogout() {
  _googleSignIn.signOut();
}

String userEmail;

void databaseUniqueid(x, y) {
  userEmail = y;

// x is the unique acc ID, if we want to transfer unique profile items, we must
// adjust the reference to this uid
  database.child(x).child('email').set(
      y); // the reference is the users auth id, which is created if there isnt one
}

void databaseProfileref(x, y) {
// x is the uid, which is unused for meow
  userEmail = y;
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username;
  String displayName;
  int numberOfCoupons;
  int numberOfRows;
  double padding;
  double width;
  double height;
  List<String> data;

  bool _isloading = true;

  /**
   * Before building the widget and ui, initState sets the necessary states
   */
  void initState() {
    super.initState();
    initUserInfo();
  }


  /**
   * initUserInfo
   * - retrieves user info from the database 
   * - init user variables
   */
  void initUserInfo() async {
    print(displayName);

    // TODO: implement setState
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    database.reference().child(user.uid).once().then((DataSnapshot snapshot) {

      //@ returns a list of values from the database
      Map<dynamic, dynamic> info = snapshot.value;

      displayName = info["accountName"];
      
      //DEBUG @@@@@@@@@
      print("$info");

     
      
      //@@@@@@@@@@@@@@/
    });

    setState(() {
      displayName = displayName;
      
    });

     _isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    data = [
      "https://nardio.net/wp-content/uploads/2017/01/Konosuba-s2-e2-feature.png",
      "https://images-na.ssl-images-amazon.com/images/I/61IB2TBKUmL._SX425_.jpg",
      "https://figuya.com/uploads/product/profile_picture/10320/profile_wiz-konosuba-2-niitengomu-gummi-anhaenger20171115-15611-z8rqew",
      "http://runt-of-the-web.com/wordpress/wp-content/uploads/2016/07/funny-spongebob-memes.jpg",
      "https://www.yourtango.com/sites/default/files/styles/header_slider/public/image_blog/spongebobmemesheader.jpg?itok=vaF4bfS7",
      "http://www.funnybeing.com/wp-content/uploads/2016/08/Studying-For-Finals-Like-600x600.jpg",
      "https://assets.simpleviewcms.com/simpleview/image/upload/c_fill,h_900,q_75,w_1600/v1/clients/lasvegas/strip3_d7b175ef-3642-41a4-9dad-33b9be2b00a9.jpg",
      "https://assets.simpleviewcms.com/simpleview/image/upload/c_fill,h_350,q_90,w_750/v1/clients/lasvegas/9162A76E5131D92FAC861416A9FE008A_2ec286f4-c45e-4811-84dd-c442f5d396b8.jpg",
      "https://d2droglu4qf8st.cloudfront.net/2017/09/346967/Korean-BBQ-Beef_ArticleImage-CategoryPage_ID-2427166.jpg?v=2427166",
      "http://www.pepper.ph/wp-content/uploads/2016/12/UbePie_CI03.jpg",
    ];

    username = userEmail;

    numberOfCoupons = data.length;
    numberOfRows = (numberOfCoupons % 3 == 0)
        ? numberOfCoupons ~/ 3
        : numberOfCoupons ~/ 3 + 1;
    padding = 2.0;
    width = MediaQuery.of(context).size.width / 3 - (4 * padding);
    height = width;

    return (_isloading == true) ? loadIndicator :

     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
    
          },
        ),
        appBar: new AppBar(
          title: new Text("$displayName's Profile"),
          backgroundColor: Color.fromRGBO(184, 52, 122, 1.0),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.input),
              onPressed: () {
                Navigator.of(context).pushNamed('/account_settings');
              },
            )
          ],
        ),
        body: new SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.account_circle,
                    size: 60.0,
                  ),
                  new Text(
                    "$displayName",
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    numberOfCoupons.toString() + " Coupons",
                    style: new TextStyle(fontStyle: FontStyle.italic),
                  ),
                  new Container(height: 10.0),
                  couponContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget couponContainer() {
    print(numberOfCoupons);
    print(numberOfRows);

    return new ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: numberOfRows,
      itemBuilder: (context, index) {
        if (index != numberOfRows - 1 || numberOfCoupons % 3 == 0) {
          return threeCellRow(index);
        } else if (numberOfCoupons % 3 == 2) {
          return twoCellRow(index);
        } else if (numberOfCoupons % 3 == 1) {
          return oneCellRow(index);
        }
      },
    );
  }

  Widget threeCellRow(int index) {
    return new Column(
      children: <Widget>[
        new Container(
          height: height,
          child: new Row(
            children: <Widget>[
              new Container(width: padding),
              new Container(
                width: width,
                height: height,
                color: Colors.black,
                child: coverNetworkImage(data[index * 3]),
              ),
              new Container(width: padding),
              new Container(
                width: width,
                height: height,
                color: Colors.black,
                child: coverNetworkImage(data[index * 3 + 1]),
              ),
              new Container(width: padding),
              new Container(
                width: width,
                height: height,
                color: Colors.black,
                child: coverNetworkImage(data[index * 3 + 2]),
              ),
              new Container(width: padding),
            ],
          ),
        ),
        new Container(height: padding),
      ],
    );
  }

  Widget twoCellRow(int index) {
    return new Column(
      children: <Widget>[
        new Container(
          height: height,
          child: new Row(
            children: <Widget>[
              new Container(width: padding),
              new Container(
                width: width,
                height: height,
                color: Colors.black,
                child: coverNetworkImage(data[index * 3]),
              ),
              new Container(width: padding),
              new Container(
                width: width,
                height: height,
                color: Colors.black,
                child: coverNetworkImage(data[index * 3 + 1]),
              ),
            ],
          ),
        ),
        new Container(height: padding),
      ],
    );
  }

  Widget oneCellRow(int index) {
    return new Column(
      children: <Widget>[
        new Container(
          height: height,
          child: new Row(
            children: <Widget>[
              new Container(width: padding),
              new Container(
                width: width,
                height: height,
                color: Colors.black,
                child: coverNetworkImage(data[index * 3]),
              ),
            ],
          ),
        ),
        new Container(height: padding),
      ],
    );
  }

  Widget coverNetworkImage(String url) {
    return new Image.network(
      url,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }
}


// Indicator Page

Widget loadIndicator (){  
return MaterialApp(
  home:Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  )
);
}
