import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

String couponVal;

void scannedValueCoupon(x) {
  couponVal = x;
  
}
class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Center(
            child: Container(
              child: Text(couponVal),
            ),
          ),
        )
      )
    );
  }
}