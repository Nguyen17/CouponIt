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
          backgroundColor: Color.fromRGBO(255, 31, 105, 1.0),
          body: Center(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Scan Code.",
                      style: TextStyle(
                          fontFamily: "Kotori",
                          fontSize: 34.0,
                          color: Color.fromRGBO(255, 255, 255, 1.0)
                          
                          ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                   
                    new QrImage(
                      data: couponCode,
                      size: 280.0,
                      foregroundColor: Colors.white,
                    ),
                    SizedBox(height: 40.0),
                     Text("or type",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SFProText",
                      fontSize: 14.0
                    ),),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color:Colors.black38,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            couponCode,
                            style: TextStyle(
                                fontFamily: "SFProText",
                                fontSize: 21.0,
                                fontWeight: FontWeight.w700,
                                // color: Color.fromRGBO(159,253,198, 1.0)),
                                color: Colors.white
                                
                                )
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "share with friends: ",
                          style: TextStyle(
                              fontFamily: "SFProText",
                              fontSize: 15.0,
                              color: Colors.white
                              // color:Colors.black54
                              ),
                        ),
                        Container(
                          width: 44.0,
                          height: 44.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(
                            onPressed: () {
                              Share.share("Your friend shared a coupon!: \n" +
                                  couponImageLink +
                                  "\n" +
                                  couponDescription +
                                  "\n\n" +
                                  "coupon code: " +
                                  couponCode +
                                  "\n\n" +
                                  "Download Coupon It. app: https://nguyen17.github.io/CouponIt"
                                  );
                            },
                            icon: Icon(CommunityMaterialIcons.telegram,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
