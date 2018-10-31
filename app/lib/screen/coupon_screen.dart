import 'package:flutter/material.dart';
// import 'app_screen.dart';

/**
 * Importing UI Packages
 */
import 'package:backdrop/backdrop.dart';

// ===========================
String couponVal;

////**
///* USAGE
///* - Text(couponVal)
///*   - display return barcode after scanning
///*/
void scannedValue(x) {
  couponVal = x;
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
            child: Text(couponVal),
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
