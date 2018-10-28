import 'package:flutter/material.dart';
import 'app_screen.dart';


/**
 * Importing UI Packages
 */
import 'package:backdrop/backdrop.dart';


// ===========================
String coupon_val;

/**
 * USAGE
 * - Text(coupon_val)
 *   - display return barcode after scanning
 */
void scanned_value(x){
coupon_val = x;
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
          child: Text(coupon_val),
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