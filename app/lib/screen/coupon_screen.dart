import 'package:flutter/material.dart';
// import 'app_screen.dart';

// /**
//  * Importing UI Packages
//  */
import 'package:backdrop/backdrop.dart';


import 'package:firebase_database/firebase_database.dart';
DatabaseReference database = FirebaseDatabase.instance.reference();

// /**
//  * DEBUG TEST
//  * - create test barcode string to debug database
//  */
String barcodeTest = "SDFDS";



// ===========================
String couponVal;

////**
///* USAGE
///* - Text(couponVal)
///*   - display return barcode after scanning
///*/
void scannedValue(x) {
  
  couponVal = x;
 

    // x is the hard coded coupon number value
database.reference().child('Coupons').child(x).once().then((DataSnapshot snapshot) {
   
   Map<dynamic,dynamic> info = snapshot.value;

   print("$info");
   // barcodetest is the variable being printed below Text(barcodeText)
   // acquire the value associated to Name in the database
   barcodeTest = info['Name'];
   print(barcodeTest);
    });
}







class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BackdropScaffold(
          title: Text("Coupons"),
          backLayer: Center(
            child: Text("Back Layer"),
          ),
          frontLayer: Center(
            child: Text(barcodeTest),
          ),
          iconPosition: BackdropIconPosition.leading,
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            ),
          ],
        ));
        
  }
}
