import 'package:flutter/material.dart';

/** 
 * Importing the Barcode Scan Module
 * * REFER TO DOCUMENTATION
 * * - https://pub.dartlang.org/packages/barcode_scan#-readme-tab-
 */
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/** 
 * Importing dart libraries
 * - dart:async 
 *    - handles promises function
 *    - also needs to store http requests and responses
 */
import 'dart:async';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("Coupon It")),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          title: Text("menu"),
          icon: IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
        ),
        BottomNavigationBarItem(
          title: Text("scan"),
          icon: IconButton(
              icon: Icon(Icons.fullscreen),

              // Todos: Implement scan
              onPressed: () {
                scan();
        
              }),
        ),
        BottomNavigationBarItem(
          title: Text("friends"),
          icon: IconButton(
              icon: Icon(Icons.people),
              onPressed: () {
                
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
