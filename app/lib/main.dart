import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// /**
//  * Importing Screens and Components
//  * * Screens
//  *  - use for defining page routes
//  */
import 'screen/profile_screen.dart';
import 'screen/account_settings_screen.dart';
import 'screen/sign_up_email_screen.dart';
import 'screen/sign_up_password_screen.dart';
import 'screen/app_screen.dart';
import 'screen/sign_up_screen.dart';
import 'screen/login_screen.dart';
import 'screen/welcome_screen.dart';
import 'screen/menu_screen.dart';
import 'screen/price_screen.dart';
import 'screen/price_track_screen.dart';
import 'screen/coupon_screen.dart';
import 'screen/splash_screen.dart';


void main(){
  runApp(App());
}

// /**
//  * App 
//  * * This is the main file
//  * * - contains routes that store the location of pages
//  */

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Coupon It",
      initialRoute: '/',
      routes:{
        '/': (context) => WelcomeScreen(),
        '/login':(context) => LoginScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/sign_up_email':(context) => SignUpEmail(),
        '/sign_up_password':  (context)=>SignUpPassword(),
        '/profile': (context)=>ProfileScreen(),
        '/account_settings': (context) => AccountSettingsScreen(),
        '/menu':(context) => MenuScreen(),
        '/price':(context) => PriceScreen(),
        '/home': (context) => AppScreen(),
        '/coupon': (context) => CouponScreen(),
        '/price_track': (context) => PriceTracker()
      },
    );
  }
}