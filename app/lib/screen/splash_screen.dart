import 'package:flutter/material.dart';
import "package:splashscreen/splashscreen.dart";
import 'welcome_screen.dart';

class SplashScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
seconds: 3,
navigateAfterSeconds: WelcomeScreen(),
 title: new Text('Coupon It.',
      style: new TextStyle(
        fontFamily: "Kotori",
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 44.0
      ),),
image:Image.asset("assets/images/logo.png"),
backgroundColor:Color.fromRGBO(191, 32, 159, 1.0) ,
photoSize: 100.0,
loaderColor: Colors.red,
 styleTextUnderTheLoader: new TextStyle(
   fontSize: 12.0
 )
    );
  }
}