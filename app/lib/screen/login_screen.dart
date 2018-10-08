import 'package:flutter/material.dart';
import 'dart:async';
/* 
  Import necessary components

 */

/**
 * Importing Firebase Authentification
 * * - with google sign in feature
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
 @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool validateSave() {
    // if the credentials are correct then we can progress in authenticating the user
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      return true;
    } else {
      return false;
    }
  }

  userLogin () {
    _auth.signInWithEmailAndPassword(email: _email, password: _password ).then((user){

      print("User email: ${user.email}");
      Navigator.of(context).pushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Hero(
      tag: "hero",
      child: Scaffold(

          //* Create a Button that when pressed goes to the sign up pages
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(218, 71, 223, 1.0),
              child: Icon(Icons.person_add),
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              }),

          //* Contains blurred background and main login ui
          // ? Will the form work
          //! Might need to replace the widgets with the full code
          //! in order to access form context
          body: Stack(children: <Widget>[
            // Display Background image
            loginBg,

            // Display form UI
            Center(
                child: Form(
                    key: _formKey,
                    child: Container(
                        padding: EdgeInsets.all(5.0),
                        width: 300.0,
                        height: 500.0,
                        child: ListView(children: <Widget>[
                          //* Login Title
                          loginTitle,
                          // ============

                          //* Login Email info
                          Container(
                              margin: EdgeInsets.fromLTRB(5.0, 44.0, 5.0, 10.0),
                              color: Colors.white,
                              height: 51.0,
                              child: ListTile(
                                  leading: Icon(Icons.email),
                                  title: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (val) => _email = val,
                                    validator: (value) => value.isEmpty
                                        ? "Email can\'t be empty"
                                        : null,
                                    onFieldSubmitted: (value) => _email = value,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: "email",
                                      hintStyle: TextStyle(fontSize: 11.0),
                                      border: InputBorder.none,
                                    ),
                                  ))),

                          //* Login Password info
                          Container(
                              margin: EdgeInsets.fromLTRB(5.0, 16.0, 5.0, 20.0),
                              color: Colors.white,
                              height: 51.0,
                              child: ListTile(
                                  leading: Icon(Icons.lock_outline),
                                  title: TextFormField(
                                  
                                    onSaved: (val) => _password = val,
                                    validator: (value) => value.isEmpty
                                        ? "Email can\'t be empty"
                                        : null,
                                    onFieldSubmitted: (value) => _password = value,
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "password",
                                      hintStyle: TextStyle(fontSize: 11.0),
                                      border: InputBorder.none,
                                    ),
                                  ))),

                          //* Login Button
                          Container(
                              margin:
                                  EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
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
                              child: FlatButton(
                                  onPressed: () {
                                    //? This print is for debug
                                    print("Hello");
                                    _formKey.currentState.save();
                                    userLogin();
                                  },
                                  child:
                                      Text("Login", style: loginButtonStyle))),
                          SizedBox(height: 20.0),
                          googleLoginButton(context)
                        ]))))
          ])),
    ));
  }
} // END OF LoginScreen Class

/** 
 * Sign Up Email Components
 *
 * ================================= 
 */

/** 
 * LoginBg
 * @contains the blurred image background
 */
Widget loginBg = Positioned(
    child: Container(
  decoration: BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.fill, image: AssetImage('assets/images/bg2.jpg'))),
));

/**
 * 
 * LoginScreenUI
 * * This is the container that have title, email and password input fields
 * ! LOGIN BUTTON NEED FIX
 * ? On Succesfull login take user to '/home'
 * ! The issue is with Navigator.pushedNamed(context, '/home')
 * ! having trouble getting the context
 * ! Last resort is to copy paste the whole code and no refactor
 */

/* Widget loginScreenUI(BuildContext context) {
  return Center(
      child: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.all(5.0),
              width: 300.0,
              height: 500.0,
              child: ListView(children: <Widget>[
                loginTitle,
                loginEmail,
                loginPassword,
                loginButton(context),
                SizedBox(height: 20.0),
                googleLoginButton(context)
              ]))));
}
 */
Widget loginTitle = Container(
    alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(5.0, 30.0, 20.0, 46.0),
    child: Text(
      "Coupon It",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: "Cookie",
          fontSize: 64.0,
          color:
              // Color.fromRGBO(48, 232, 208, 1.0)),
              Colors.white),
    ));

/* Widget loginEmail = Container(
    margin: EdgeInsets.fromLTRB(5.0, 44.0, 5.0, 10.0),
    color: Colors.white,
    // width: 290.0,
    height: 51.0,
    child: ListTile(
        leading: Icon(Icons.email),
        title: TextFormField(
          onSaved: (String val) {
            email = val;
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "email",
            hintStyle: TextStyle(fontSize: 11.0),
            border: InputBorder.none,
          ),
        ))); */

/* Widget loginPassword = Container(
    margin: EdgeInsets.fromLTRB(5.0, 16.0, 5.0, 20.0),
    color: Colors.white,
    // width: 290.0,
    height: 51.0,
    child: ListTile(
        leading: Icon(Icons.lock_outline),
        title: TextFormField(
          onSaved: (String val) {
            password = val;
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "password",
            hintStyle: TextStyle(fontSize: 11.0),
            border: InputBorder.none,
          ),
        ))); */

/* Widget loginButton(BuildContext context) {
  return Container(
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
      child: FlatButton(
          onPressed: () {
            //? This print is for debug
            print("Hello");
            print("email: ${email}");
          },
          child: Text("Login", style: loginButtonStyle)));
} */

// Google login Button
Widget googleLoginButton(BuildContext context) {
  return Container(
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
      child: FlatButton(
          onPressed: () {
            //? This print is for debug
            print("Hello");
            sign_in_google();

            // Todos: FIX THIS !! <3
            Navigator.pushNamed(context, '/home');
          },
          child: Text("google sign in", style: loginButtonStyle)));
}

/**
 * External components for styling
 * 
 * ==============================================
 */
TextStyle loginButtonStyle = TextStyle(color: Colors.white);

Future<FirebaseUser> sign_in_google() async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  print("User is  ${user.displayName}");
  return user;
}




