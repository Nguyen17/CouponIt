import 'package:flutter/material.dart';
import "package:splashscreen/splashscreen.dart";
import 'welcome_screen.dart';
import 'components/color.dart';

class SplashScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
seconds: 3,
navigateAfterSeconds: WelcomeScreen(),
 title: new Text('Coupon It.',
      style: new TextStyle(
        fontFamily: "Cookie",
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 32.0
      ),),
image:Image.asset("assets/images/couponit_logo.png"),
backgroundColor:Color.fromRGBO(147, 25, 132, 1.0) ,
photoSize: 200.0,
loaderColor: pinkColorScheme,
 styleTextUnderTheLoader: new TextStyle(
   fontSize: 11.0,
   color: Colors.white
 )
    );
  }
}