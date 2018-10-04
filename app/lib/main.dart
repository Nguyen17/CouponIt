import 'package:flutter/material.dart';


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

/**
 * App 
 * * This is the main file
 * * - contains routes that store the location of pages
 */

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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