import 'package:flutter/material.dart';
import 'profile_screen.dart';

// import 'dart:async';
/**
 * 
 * Import Firebase
 * - create user account
 */
import 'package:firebase_auth/firebase_auth.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

// void validateSubmit()async{

//       Future createUserAccount(BuildContext context) async {
//     // FirebaseUser newUser = 
//     await _auth
//         .createUserWithEmailAndPassword(email: _email, password: _password)
//         .then((newUser) {
//       print("User email: ${newUser.email}");
//        databaseUniqueid(newUser.uid,_email);
//        Navigator.of(
//                 context) // route to home and remove routes (clear the stack)
//             .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
//     });
//   }
// }
void validateSubmit() async {

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((newUser) {
      print("User email: ${newUser.email}");
     databaseUniqueid(newUser.uid,_email);
        Navigator.of(
                context) // route to home and remove routes (clear the stack)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView(children: <Widget>[
      Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                width: 375.0,
                height: 304.0,
                color: Colors.white,
                child: Container(
                    margin: EdgeInsets.fromLTRB(40.0, 20.0, 20.0, 20.0),
                    child: Text("Sign up",
                        style: TextStyle(
                            fontFamily: "Kotori",
                            fontWeight: FontWeight.w700,
                            fontSize: 44.0,
                            color: Colors.black)))),
            //* User Email input
            Container(
              width: 375.0,
              height: 304.0,
              color: Color.fromRGBO(139, 252, 255, 1.0),
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.fromLTRB(40.0, 40.0, 20.0, 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 170.0,
                          alignment: Alignment.centerLeft,
                          child: Text("Enter an email.",
                              style: TextStyle(
                                  fontFamily: "Kotori",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 44.0,
                                  color: Colors.black))),
                      SizedBox(height: 44.0),
                      Container(
                          color: Colors.white,
                          child: ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              title: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    hintText: "email",
                                    contentPadding: EdgeInsets.all(20.0),
                                    fillColor: Colors.white),
                                onSaved: (val) => _email = val,
                              )))
                    ],
                  )),
            ),
            //* User Password input
            Container(
              width: 375.0,
              height: 304.0,
              color: Color.fromRGBO(245, 67, 246, 1.0),
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.fromLTRB(40.0, 40.0, 20.0, 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 290.0,
                          alignment: Alignment.centerLeft,
                          child: Text("Enter a password.",
                              style: TextStyle(
                                  fontFamily: "Kotori",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 44.0,
                                  color: Colors.black))),
                      SizedBox(height: 44.0),
                      Container(
                          color: Colors.white,
                          child: ListTile(
                              leading: Icon(
                                Icons.lock_outline,
                                color: Colors.black,
                              ),
                              title: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      hintText: "password",
                                      contentPadding: EdgeInsets.all(20.0),
                                      fillColor: Colors.white),
                                  onSaved: (val) => _password = val))),
                    ],
                  )),
            ),
            Container(
              width: 375.0,
              height: 304.0,
              color: Colors.white,
              alignment: Alignment.center,
              child: Container(
                  width: 264.0,
                  height: 54.0,
                  margin: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(233, 183, 255, 1.0),
                      Color.fromRGBO(193, 193, 255, 1.0),
                      Color.fromRGBO(144, 203, 255, 1.0),
                      Color.fromRGBO(91, 211, 255, 1.0),
                      Color.fromRGBO(44, 216, 250, 1.0),
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    // stops: [0.2,0.2,0.2,0.2,0.2],
                    // tileMode: TileMode.mirror
                  )),

                  //* Create Account Button
                  //* creates a new user and send to firebase
                  child: FlatButton(
                      onPressed: () {
                        _formKey.currentState.save();
                        //? This print is for debug
                        print("Hello");
                        print(_email);
                        print(_password);

                        // Todos: FIX THIS !! <3
                        // createUserAccount(context);
                        validateSubmit();
                      },
                      child: Text("Create Account",
                          style: TextStyle(color: Colors.white)))),
            )
          ]))
    ])));
  }


} // END OF SIGN UP CLASS
