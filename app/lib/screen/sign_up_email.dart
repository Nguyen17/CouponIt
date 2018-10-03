import 'package:flutter/material.dart';



class SignUpEmail extends StatefulWidget {
  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Hero(
            tag: 'hero',
            child: Scaffold(
                body: Container(
              constraints: BoxConstraints.expand(),
              color: Color.fromRGBO(139, 252, 255, 1.0),
              child: ListView(children: <Widget>[
                Stack(children: <Widget>[

                  //* Contains Header Title
                  emailTitle,

                  //* Contains message to input email
                  emailMsg,

                  //* Contains the form field to input email
                  emailFormField,

                  //* NEXT component
                  //* - when a user clicks the next bottom 
                  //*   takes the user to the password page 
                  Positioned(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(243.0, 564.0, 0.0, 20.0),
                          child: FlatButton(
                              child: Text("Next",
                                  style: TextStyle(
                                      fontFamily: "Kotori",
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/sign_up_password');
                              })))
                ]),
              ]),
            ))));
  }
}

/**
 * Sign Up Email Component Widgets
 */

Widget emailTitle = Positioned(
    child: Container(
        margin: EdgeInsets.fromLTRB(45.0, 96.0, 0.0, 40.0),
        child: Text("Sign Up",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Kotori",
                fontSize: 44.0,
                fontWeight: FontWeight.w700))));

Widget emailMsg = Positioned(
    child: Container(
  width: 155.0,
  margin: EdgeInsets.fromLTRB(45.0, 224.0, 0.0, 40.0),
  child: Text("Enter an email.",
      style: TextStyle(
          fontFamily: "Kotori",
          fontSize: 32.0,
          fontWeight: FontWeight.w700,
          color: Colors.black)),
));

Widget emailFormField = Positioned(
    child: Container(
        width: 290.0,
        margin: EdgeInsets.fromLTRB(45.0, 403.0, 0.0, 40.0),
        child: Form(child: Column(children: <Widget>[passwordInput]))));
Widget passwordInput = TextFormField(
  decoration: InputDecoration(
      icon: Icon(
        Icons.lock_outline,
        color: Colors.white,
      ),
      border: InputBorder.none,
      filled: true,
      labelText: "email",
      fillColor: Colors.white),
);


