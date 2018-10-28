import 'package:flutter/material.dart';



class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
        body: Container(
         alignment: Alignment.center,
         child: Text("This is the coupon screen.") 
        )
      )
      )
    );
  }
}