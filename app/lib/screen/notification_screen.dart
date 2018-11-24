import 'package:flutter/material.dart';
import 'components/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:onesignal/onesignal.dart';

import 'dart:async';
import 'package:flutter/services.dart';

import 'app_screen.dart';
import 'package:CouponIt/models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  
  String barcode;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // setNotification();
    }


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: lightGrey,

          appBar: AppBar(
            backgroundColor: pinkColorScheme,
      
            leading: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Row(
              children: <Widget>[
                Image.asset("assets/images/ic_couponitlogo_2.png"),
                Text("Notifications",
                style: TextStyle(
                  fontFamily: "SFProText",
                  fontSize: 15.0
                ),)
              ],
            ),
            actions: <Widget>[
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          ),
          body: Center(
            child: Container(
              // child: Text("No Notifications at the moment :c"),
              child: Text("No notifications at the moment :c",
               style: TextStyle(
                  fontFamily: "SFProText",
                  fontSize: 15.0
                ),),
            )
          ),
        ));
  }


}
