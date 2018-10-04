import 'package:flutter/material.dart';

class SignUpPassword extends StatefulWidget {
  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Hero(
            tag: 'hero',
            child: Scaffold(
                body: Container(
              constraints: BoxConstraints.expand(),
              color: Color.fromRGBO(218, 71, 255, 1.0),
              child: ListView(children: <Widget>[
                Stack(children: <Widget>[
                  passwordTitle,
                  passwordMsg,
                  passwordFormField,

                  //* Done Button should return back to login screen
                  //! Might need to replace widget with full code
                  Positioned(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(243.0, 564.0, 0.0, 20.0),
                          child: FlatButton(
                              child: Text("Done",
                                  style: TextStyle(
                                      fontFamily: "Kotori",
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                              onPressed: () {
                                Navigator.pushNamed(context, '/');
                              })))
                ]),
              ]),
            ))));
  }
}

/**
 * Sign Up Components
 * * these custom widgets are 
 * * - passwordTitle, passwordMsg passwordFormField
 */

Widget passwordTitle = Positioned(
    child: Container(
        margin: EdgeInsets.fromLTRB(45.0, 96.0, 0.0, 40.0),
        child: Text("Sign Up",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Kotori",
                fontSize: 44.0,
                fontWeight: FontWeight.w700))));

Widget passwordMsg = Positioned(
    child: Container(
  width: 155.0,
  margin: EdgeInsets.fromLTRB(45.0, 224.0, 0.0, 40.0),
  child: Text("Enter a password.",
      style: TextStyle(
          fontFamily: "Kotori",
          fontSize: 32.0,
          fontWeight: FontWeight.w700,
          color: Colors.black)),
));

Widget passwordFormField = Positioned(
    child: Container(
        width: 290.0,
        margin: EdgeInsets.fromLTRB(45.0, 403.0, 0.0, 40.0),
        child: Form(child: Column(children: <Widget>[passwordInput]))));

Widget passwordInput = TextFormField(
  decoration: InputDecoration(
      border: InputBorder.none,
      icon: Icon(
        Icons.lock_outline,
        color: Colors.white,
      ),
      filled: true,
      labelText: "password",
      fillColor: Colors.white),
);
