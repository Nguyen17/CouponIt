import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'components/data/coupons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

/// Importing Screens for Navigation
import 'coupon_qr_screen.dart';
import '../models/coupon_store.dart';
String couponVal;

void scannedValueCoupon(x) {
  couponVal = x;
}

class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  Map<dynamic, dynamic> productModel;
  List coupons;

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {

    return (!productModel[couponVal] ) ?  errorDisplay() :
     MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // Container(
          //     height: 400.0,
          //     decoration: BoxDecoration(
          //         image: DecorationImage(
          //       fit: BoxFit.cover,
          //       image: NetworkImage(
          //           productModel["073854008089"][0]["itemImgUrl"]),
          //     ))),
          //     SizedBox(height:20.0),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productModel[couponVal][0]["coupons"].length,
            itemBuilder: (BuildContext context, int index) {
              return Card(

                /// Render a list 
                /// - coupon discount rate / desc
                /// - coupon title
                /// - coupon code
                child: ListTile(
                  contentPadding: EdgeInsets.all(20.0),
                  leading: AutoSizeText(
                    productModel[couponVal][0]["coupons"][index]
                        ["couponType"],
                    softWrap: true,
                    maxLines: 3,
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: "SFProText",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                  title: AutoSizeText(
                      productModel[couponVal][0]["coupons"][index]
                          ["couponTitle"],
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black45,
                        fontFamily: "SFProText",
                        fontSize: 11.0,
                      )),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: MaterialButton(
                      onPressed: () {
                      
                        couponDescription =productModel[couponVal][0]["coupons"][index]
                          ["couponTitle"];
                        couponLink=productModel[couponVal][0]["coupons"][index]
                              ["couponSrcUrl"];
                        couponCode = productModel[couponVal][0]["coupons"][index]
                              ["couponCode"];
                        couponImageLink = productModel[couponVal][0]["itemImgUrl"];
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CouponQR()
                        ));
                      },
                      child: AutoSizeText(
                          productModel[couponVal][0]["coupons"][index]
                              ["couponCode"],
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SFProText",
                            fontSize: 10.0,
                          )),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  /** 
   * Fetch Coupons data
   */

  retrieveData() {
    productModel = products;

    print(productModel);
    print(productModel[couponVal][0]["coupons"][0]["couponType"]);
    print(productModel[couponVal][0]["coupons"][0]["couponTitle"]);
    print(productModel[couponVal][0]["coupons"][0]["couponCode"]);
  }


  Widget errorDisplay(){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Sorry, No discount found :c"),
        )
      )
    );
  }
}
