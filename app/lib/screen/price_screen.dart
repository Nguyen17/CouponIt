import 'package:flutter/material.dart';
import 'components/color.dart';
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'app_screen.dart';
// /**
//  * Importing UI Packages
//  */
// import 'package:backdrop/backdrop.dart';

import 'package:firebase_database/firebase_database.dart';

DatabaseReference database = FirebaseDatabase.instance.reference();



// ===========================
String priceVal;
bool _isloading = true;

////**
///* USAGE
///* - Text(couponVal)
///*   - display return barcode after scanning
///*/
void scannedValue(x) {
  priceVal = x;

//     // x is the hard coded coupon number value
// database.reference().child('Coupons').child(x).once().then((DataSnapshot snapshot) {

//    Map<dynamic,dynamic> info = snapshot.value;

//    print("$info");
//    // barcodetest is the variable being printed below Text(barcodeText)
//    // acquire the value associated to Name in the database
//    barcodeTest = info['Name'];
//    print(barcodeTest);
//     });
}
  String testBarcode= "073854008089";

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
 
  Map<dynamic, dynamic> itemModel;
  List items;

  void initState() {
    super.initState();
    fetchData();
  
  }

  _launchURL(urlTest) async {
    var url = urlTest;
    if (await canLaunch(url)) {
      _isloading = true;
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  var apiToken = "auvc3z69w04brkitdxg03bx5r1lhem";
  var url ="https://api.barcodelookup.com/v2/products?barcode=$priceVal&formatted=y&key=auvc3z69w04brkitdxg03bx5r1lhem";
  @override
  Widget build(BuildContext context) {

    // return MaterialApp(
    //   home:Scaffold(
    //     body: Center(
    //       child: Container(
    //         child: Text(priceVal)
    //       ),
    //     )
    //   )
    // );
    return (_isloading == true)
        // ? loadingIcon() : MaterialApp(home: Scaffold(body: Center(child: Text(priceVal))));
      ? loadingIcon() : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
                child: Scaffold(
              body:
                  ListView.builder(
                      itemCount: items == null ? 0 : items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Text(items[index]['currency_symbol'] +
                              items[index]['store_price']),
                          title: Text(items[index]['store_name']),
                          trailing: MaterialButton(
                            child: Text("buy"),
                            onPressed: () {
                              _launchURL(items[index]['product_url']);
                            },
                          ),
                        );
                        // return Card(
                        //   elevation: 2.0,
                        //   child: Flex(
                        //     direction: Axis.vertical,
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: <Widget>[
                        //       SizedBox(height: 20.0),
                        //       Text(items[index]['store_name'],
                        //           style: TextStyle(
                        //               fontFamily: "SFProText",
                        //               fontSize: 21.0,
                        //               fontWeight: FontWeight.w600)),
                        //       SizedBox(height: 20.0),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: <Widget>[
                        //           Text(
                        //             items[index]['currency_symbol'] +
                        //                 items[index]['store_price'],
                        //             style: TextStyle(
                        //                 fontFamily: "SFProText",
                        //                 fontSize: 14.0,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //           SizedBox(width: 20.0),
                        //           Container(
                        //             width: 75.0,
                        //             padding: EdgeInsets.all(0.0),
                        //             decoration: BoxDecoration(
                        //                 color: Colors.greenAccent,
                        //                 borderRadius:
                        //                     BorderRadius.circular(5.0)),
                        //             child: MaterialButton(
                        //               child: Text(
                        //                 "buy",
                        //                 style: TextStyle(
                        //                     fontFamily: "SFProText",
                        //                     fontSize: 10.0,
                        //                     color: Colors.white),
                        //               ),
                        //               onPressed: () {
                        //                 _launchURL(items[index]['product_url']);
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(height: 20.0),
                        //     ],
                        //   ),
                        // );
                      })
            
         
            )));
  }

  Future fetchData() async {
    var res = await get(url);
    //debugPrint(res.body);
    itemModel = json.decode(res.body);

    setState(() {
      items = itemModel["products"][0]["stores"];
  
    });

    print(items);
    print(items.length);
    _isloading = false;
  }
}

Widget loadingIcon() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body:Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/money.png",
                width: 250.0, height: 250.0),
            SizedBox(height: 40.0),
            Text("Getting the prices right now!",
            style: TextStyle(
              
              color: Colors.black,
              fontFamily: "SFProText",
              fontSize: 17.0,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 20.0),
            SpinKitThreeBounce(
              color: pinkColorScheme,
              size: 21.0,
            )
          ],
        ),
      ))
    )
  );
}
