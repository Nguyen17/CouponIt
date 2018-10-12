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

class AppScreen extends StatefulWidget {
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  // This is a variables that holds the return value of the Scan method
  String barcode = '';

  @override
  initState() {
    super.initState();
  }

  sign_out() {
    FirebaseAuth.instance.signOut().then((user) {
      Navigator.of(context).pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text("Coupon It")),
          bottomNavigationBar: BottomNavigationBar(
           
            type: BottomNavigationBarType.shifting,
            iconSize: 12.0, items: [
            /** 
             * Todo: CREATE 4-5 items of navigation
             */
      
            BottomNavigationBarItem(
              title: Text("search"),
              icon: IconButton(
                  color: Colors.black45,
                  icon: Icon(FontAwesomeIcons.search),
                  onPressed: () {}),
            ),
            BottomNavigationBarItem(
              title: Text("saved deals"),
              icon: IconButton(
                  color: Colors.black45,
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {}),
            ),
            BottomNavigationBarItem(
              title: Text("scan"),
              icon: IconButton(
                  color: Colors.black45,
                  icon: Icon(FontAwesomeIcons.barcode),

                  // Todos: Implement scan
                  onPressed: () {
                    scan();
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
              title: Text("sign out"),
              icon: IconButton(
                  color: Colors.black45,
                  icon: Icon(Icons.input),
                  onPressed: () {
                    sign_out();
                    google_logout();
                  }),
            ),
          ]),
        ));
  }

/**
 * Scan METHOD
 * @This is a method of AppScreen class Widget
 * @learn about future and promise
 * refer to barcode scan documentations
 */
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
} // End of AppScreen CLASS
