import 'package:flutter/material.dart';

/**
 * Importing icons from Font Awesome
 */
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/**
 * Importing Modules for Firebase
 */
import 'package:firebase_auth/firebase_auth.dart';

/**
 * Importing Google Modules
 */
import 'package:google_sign_in/google_sign_in.dart';
/** 
 * Importing the Barcode Scan Module
 * * REFER TO DOCUMENTATION
 * * - https://pub.dartlang.org/packages/barcode_scan#-readme-tab-
 */
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

/** 
 * Importing dart libraries
 * - dart:async 
 *    - handles promises function
 *    - also needs to store http requests and responses
 */
import 'dart:async';

final GoogleSignIn _googleSignIn = GoogleSignIn();

/** 
 * EXTERNAL METHODS
 */
google_logout() {
  _googleSignIn.signOut();
}

class ProfileScreen extends StatelessWidget {
  String username = "KrustyKrab";
  int numberOfCoupons = 29;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("$username's Profile"),
          backgroundColor: Color.fromRGBO(184, 52, 122, 1.0),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.input),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((user) {
                  Navigator.of(context).pushNamed('/');
                });
                _googleSignIn.signOut();
              },
            )
          ],
        ),
        body: new Container(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.account_circle,
                  size: 60.0,
                ),
                new Text(
                  "$username",
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                new Text(
                  numberOfCoupons.toString() + " Coupons",
                  style: new TextStyle(fontStyle: FontStyle.italic),
                ),
                new Container(height: 10.0),
                new CouponContainer(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.black45,
            iconSize: 21.0,
            items: [
              /** 
             * Todo: CREATE 4-5 items of navigation
             */

              // BottomNavigationBarItem(
              //   title: Text("search"),
              //   icon: IconButton(
              //       color: Colors.black45,
              //       icon: Icon(FontAwesomeIcons.search),
              //       onPressed: () {}),
              // ),
              BottomNavigationBarItem(
                title: Text("menu"),
                icon: IconButton(
                    color: Colors.black45,
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              BottomNavigationBarItem(
                title: Text("scan"),
                icon: IconButton(
                    color: Colors.black45,
                    icon: Icon(FontAwesomeIcons.barcode),

                    // Todos: Implement scan
                    onPressed: () {
                      // scan()
                    }),
              ),
              // BottomNavigationBarItem(
              //   title: Text("friends"),
              //   icon: IconButton(
              //       icon: Icon(Icons.people),
              //       onPressed: () {

              //       }),
              // ),
              BottomNavigationBarItem(
                title: Text("Profile"),
                icon: IconButton(
                    color: Colors.black45,
                    icon: Icon(Icons.account_box),
                    onPressed: () {
                      //Navigator.of(context).pushNamed('/profile');
                      // sign_out();
                      // google_logout();
                    }),
              ),
            ]),
      ),
    );
  }
}

class CouponContainer extends StatelessWidget {
  int numberOfRows = 10;
  double paddingSize = 4.0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width / 3;

    return new Expanded(
      child: new ListView.builder(
        itemCount: numberOfRows,
        itemBuilder: (context, index) {
          return new Column(
            children: <Widget>[
              new Container(
                height: height,
                child: Row(
                  children: <Widget>[
                    new Container(width: paddingSize),
                    new Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.orange : Colors.blue,
                        child: Center(child:new Text("" + (index * 3 + 0).toString())),
                      ),
                    ),
                    new Container(width: paddingSize),
                    new Expanded(
                      child: Container(
                        color:index % 2 == 0 ? Colors.cyanAccent : Colors.grey,
                        child: Center(child:new Text("" + (index * 3 + 1).toString())),
                      ),
                    ),
                    new Container(width: paddingSize),
                    new Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.green : Colors.amber,
                        child: Center(child:new Text("" + (index * 3 + 2).toString())),
                      ),
                    ),
                    new Container(width: paddingSize),
                  ],
                ),
              ),
              new Container(height: paddingSize),
            ],
          );
        },
      ),
    );
  }
}

/**
 * Scan METHOD
 * @This is a method of AppScreen class Widget
 * @learn about future and promise
 * refer to barcode scan documentations
 */
//   Future scan() async {
//     try {
//       String barcode = await BarcodeScanner.scan();
//       setState(() => this.barcode = barcode);
//     } on PlatformException catch (e) {
//       if (e.code == BarcodeScanner.CameraAccessDenied) {
//         setState(() {
//           this.barcode = 'The user did not grant the camera permission!';
//         });
//       } else {
//         setState(() => this.barcode = 'Unknown error: $e');
//       }
//     } on FormatException {
//       setState(() => this.barcode =
//           'null (User returned using the "back"-button before scanning anything. Result)');
//     } catch (e) {
//       setState(() => this.barcode = 'Unknown error: $e');
//     }
//   }
// } // End of AppScreen CLASS
