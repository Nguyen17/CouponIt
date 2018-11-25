import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'account_settings_screen.dart';
import 'login_screen.dart';
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
  FirebaseUser currentUser;
  Map userInfo;
  String username = 'User';
  String displayName;
  int numberOfCoupons;
  int numberOfRows;
  double padding;
  double width;
  double height;
  List<String> data = [];

  // bool _isloading = true;

  // /**
  //  * Before building the widget and ui, initState sets the necessary states
  //  */
  void initState() {
    super.initState();
    fetchUser().then((foundUser) {
      if (foundUser) {
        fetchUserInfo().then((userInfo) {
          this.userInfo = userInfo.value;
          // setDisplayName();
          setCoupons();
          database
              .child(currentUser.uid)
              .child('displayName')
              .onValue
              .listen((value) {
            setState(() {
              displayName = value.snapshot.value;
            });
          });
        });
      }
    });
  }

  Future<bool> fetchUser() async {
    return FirebaseAuth.instance.currentUser().then((user) {
      if (user == null) {
        setState(() {
          displayName = "Guest";
          return false;
        });
      }
      currentUser = user;
      return true;
    });
  }

  Future fetchUserInfo() async {
    return database.child(currentUser.uid).once();
  }

  void setDisplayName() {
    setState(() {
      displayName = userInfo['displayName'] != null
          ? userInfo['displayName']
          : currentUser.email;
    });
  }

  void setCoupons() {
    List<String> imgUrls = [];
    if (userInfo['coupons'] != null) {
      userInfo['coupons'].forEach((item) {
        imgUrls.add(item);
      });
    }
    setState(() {
      data = imgUrls;
    });
  }

  @override
  Widget build(BuildContext context) {
    numberOfCoupons = data.length;
    numberOfRows = (numberOfCoupons % 3 == 0)
        ? numberOfCoupons ~/ 3
        : numberOfCoupons ~/ 3 + 1;
    padding = 2.0;
    width = MediaQuery.of(context).size.width / 3 - (4 * padding);
    height = width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        appBar: new AppBar(
          title: new Text("$displayName's Profile"),
          backgroundColor: Color.fromRGBO(184, 52, 122, 1.0),
          actions: <Widget>[
            IconButton(
              icon: new Icon(CommunityMaterialIcons.settings),
              onPressed: () {
                if (currentUser == null) {
                  // Signout
                  FirebaseAuth.instance.signOut().then((user) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  });
                  _googleSignIn.signOut();
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AccountSettingsScreen()));
                }
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

Widget loadIndicator() {
  return MaterialApp(
      home: Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  ));
}
