import 'package:flutter/material.dart';


// Importing Login page
import './screens/Login.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Coupon It",
      home: Login(),
    );
  }
}
