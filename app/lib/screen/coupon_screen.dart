import 'package:flutter/material.dart';
import 'app_screen.dart';
String coupon_val;

void scanned_value(x){
coupon_val = x;
}

class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
        body: Container(
         alignment: Alignment.center,
         child: Text(coupon_val) 
        )
      )
      )
    );
  }
}