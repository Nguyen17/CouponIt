import 'package:flutter/material.dart';
import 'components/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:shimmer/shimmer.dart';

import 'price_screen.dart';

class PriceTracker extends StatefulWidget {
  @override
  _PriceTrackerState createState() => _PriceTrackerState();
}

class _PriceTrackerState extends State<PriceTracker> {
  String barcode;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: lightGrey,
          floatingActionButton: FloatingActionButton(
              backgroundColor: pinkColorScheme,
              onPressed: () {
                scan();
              },
              child: Icon(FontAwesomeIcons.barcode)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            backgroundColor: pinkColorScheme,
            leading: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Image.asset("assets/images/ic_couponitlogo_2.png"),
            // actions: <Widget>[
            //   IconButton(onPressed: () {}, icon: Icon(Icons.search))
            // ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/loading.png",
                    width: 300.0, height: 300.0),
                // Icon(Icons.search,
                // size: 150.0),
                SizedBox(height: 20.0),
                AutoSizeText(
                  "Search for a price.",
                  style: TextStyle(
                      fontFamily: "SFProText",
                      fontSize: 21.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.0),
                Shimmer.fromColors(
                  baseColor: Colors.blueGrey,
                  highlightColor: Colors.pinkAccent,
                  child:  AutoSizeText("Tap on button below.",
                    style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 11.0,
                        color: Colors.black45)),
                ),
                SizedBox(height: 10.0),
                Icon(
                  Icons.arrow_downward,
                  color: Colors.black45,
                )
              ],
            ),
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      scannedValue(barcode);
      setState(() => this.barcode = barcode);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => PriceScreen()
      ));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
