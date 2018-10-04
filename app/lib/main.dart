import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

/**
 * Importing Screens and Components
 * * Screens
 *  - use for defining page routes
 */
import 'screen/login_screen.dart';
import 'screen/sign_up_email_screen.dart';
import 'screen/sign_up_password_screen.dart';
import 'screen/app_screen.dart';
void main(){
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coupon It",
      initialRoute: '/',
      routes:{
        '/': (context) => LoginScreen(),
        '/sign_up_email':(context) => SignUpEmail(),
        '/sign_up_password':  (context)=>SignUpPassword(),
        '/home': (context) => AppScreen()
      },
    );
  }
}