import 'package:flutter/material.dart';

/// Importing App Components
import 'components/ui/heart_widget.dart';
import 'components/color.dart';
import 'components/data/coupons.dart';

/// Importing UI Dependencies
import 'package:community_material_icon/community_material_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shimmer/shimmer.dart';

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          /// Create a list of coupons
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productModel[couponVal][0]["coupons"].length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                delegate: SlidableDrawerDelegate(),
                actionExtentRatio: 0.25,
                child: Card(
                  /// Render a list
                  /// - coupon discount rate / desc
                  /// - coupon title
                  /// - coupon code
                  child: ListTile(
                    onTap: () {
                      Flushbar(
                          backgroundColor: pinkColorScheme,
                          icon: Shimmer.fromColors(
                            baseColor: Colors.grey[100],
                            highlightColor: pinkColorScheme,
                            child:  Icon(
                            Icons.keyboard_arrow_left,
                        size: 24.0,
                          ),
                          ))
                        ..messageText = Text("SWIPE coupon tile left for more options\n or PRESS button to get qr code to scan!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SFProText",
                                fontSize: 13.0))
                        ..duration = Duration(seconds: 8)
                        ..show(context);
                    },
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
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                offset: Offset(1.0, 4.0),
                                blurRadius: 2.0)
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          couponDescription = productModel[couponVal][0]
                              ["coupons"][index]["couponTitle"];
                          couponLink = productModel[couponVal][0]["coupons"]
                              [index]["couponSrcUrl"];
                          couponCode = productModel[couponVal][0]["coupons"]
                              [index]["couponCode"];
                          couponImageLink =
                              productModel[couponVal][0]["itemImgUrl"];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CouponQR()));
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
                ),
                secondaryActions: <Widget>[
                  Container(
                    color: Colors.white,
                    child: new Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Flexible(
                            child: HeartButton(color: pinkColorScheme),
                          ),
                          // new Flexible(
                          //     child: Text("Like",
                          //         style: TextStyle(
                          //           color: Colors.black,
                          //           fontFamily: "SFProText",
                          //           fontSize: 11.0
                          //         )

                          //             )),
                        ],
                      ),
                    ),
                  ),
                  new IconSlideAction(
                    caption: 'Share',
                    color: Color.fromRGBO(126, 170, 255, 0.9),
                    foregroundColor: Colors.white,
                    icon: CommunityMaterialIcons.telegram,
                    onTap: () {
                      /// These are all strings
                      couponDescription = productModel[couponVal][0]["coupons"]
                          [index]["couponTitle"];
                      couponLink = productModel[couponVal][0]["coupons"][index]
                          ["couponSrcUrl"];
                      couponCode = productModel[couponVal][0]["coupons"][index]
                          ["couponCode"];
                      couponImageLink =
                          productModel[couponVal][0]["itemImgUrl"];

                      Share.share("Your friend shared a coupon!: \n" +
                          couponImageLink +
                          "\n" +
                          couponDescription +
                          "\n\n" +
                          "coupon code: " +
                          couponCode +
                          "\n\n" +
                          "Download Coupon It. app: https://nguyen17.github.io/CouponIt");
                    },
                  ),
                ],
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

  if(productModel[couponVal]== null ){
    // if the coupon value doesnt exist, then couponvalue is set default to an error code "fuckthis"
    couponVal = "fuckthis";
  }


    print(productModel);
    print(productModel[couponVal][0]["coupons"][0]["couponType"]);
    print(productModel[couponVal][0]["coupons"][0]["couponTitle"]);
    print(productModel[couponVal][0]["coupons"][0]["couponCode"]);
  }
}

Widget errorDisplay() {
  return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Text("Sorry, No discount found :c"),
      )));
}

// Widget loadingIcon() {
//   return Container(
//       child: Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Image.asset("assets/images/loading_icon.png", width: 250.0, height: 250.0),
//         SizedBox(height: 40.0),
//         SpinKitThreeBounce(
//           color: pinkColorScheme,
//           size: 21.0,
//         )
//       ],
//     ),
//   ));
// }
