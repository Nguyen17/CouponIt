import 'package:flutter/material.dart';

import '../models/coupon_store.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';

class CouponQR extends StatefulWidget {
  _CouponQRState createState() => _CouponQRState();
}

class _CouponQRState extends State<CouponQR> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromRGBO(255, 31 ,105, 1.0),
          body: Center(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Scan Code.",
                    style: TextStyle(
                      fontFamily: "Cookie",
                      fontSize: 44.0,
                      color: Color.fromRGBO(255,255,255, 1.0)
                    ),),
                    SizedBox(
                      height: 80.0,
                    ),
                    new QrImage(
                      data: couponCode,
                      size: 250.0,
                      foregroundColor: Colors.white,
                    ),
                    SizedBox(height: 40.0),
                    Text(couponCode,
                    style: TextStyle(
                      fontFamily: "SFProText",
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.greenAccent
                    ),),
                    SizedBox(height:10.0),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("share to friends: ",
                   style: TextStyle(
                     fontFamily: "SFProText",
                     fontSize: 11.0,
                     color: Colors.white
                   ),),
                        IconButton(
                      onPressed: (){
                        Share.share(
                          "Your friend shared a coupon!: \n" + couponImageLink 
                          + "\n" + couponDescription + "coupon code: " + couponCode 
                        );
                      },
                      icon: Icon(CommunityMaterialIcons.telegram,
                      color: Colors.white),
                    )

                 ],
               )
                  ]),
            ),
          ),
        ));
  }
}
