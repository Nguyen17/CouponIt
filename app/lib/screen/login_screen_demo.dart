import 'package:flutter/material.dart';
import 'dart:async';

/**
 * Importing Font awesome icons
 */
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
/**
 * Importing Firebase Authentification
 * * - with google sign in feature
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginScreenDemo extends StatefulWidget {
  _LoginScreenDemoState createState() => _LoginScreenDemoState();
}

class _LoginScreenDemoState extends State<LoginScreenDemo> {
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

  userLogin() {
    _auth
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((user) {
      print("User email: ${user.email}");
      Navigator.of(context).pushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
                floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(218, 71, 223, 1.0),
              child: Icon(Icons.person_add),
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up_email');
              }),
            body:
                //* Background color
                Stack(children: <Widget>[
          Container(color: Color.fromRGBO(255, 31, 105, 1.0)),
          //  Container(color: Colors.white),
          //* LOGO
          ListView(
            children: <Widget>[
              Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 221.0,
                        height: 204.67,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/ic_couponitlogo.png")),
                        )),
                  ]),

              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  child: Text(
                    "Coupon It",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Kotori",
                        fontSize: 44.0,
                        color:
                            // Color.fromRGBO(48, 232, 208, 1.0)),
                            Colors.white),
                  )),

              SizedBox(height: 40.0),

              //* LOGIN FORM UI

              Center(
                  child: Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        width: 300.0,
                        height: 250.0,
                        child: Column(children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
                                      filled: true,
                                      hintText: "email",
                                      hintStyle: TextStyle(fontSize: 11.0),
                                      border: InputBorder.none,
                                    ),
                                  ))),
                          Container(
                              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                              color: Colors.white,
                              height: 51.0,
                              child: ListTile(
                                  leading: Icon(Icons.lock_outline),
                                  title: TextFormField(
                                    onSaved: (val) => _password = val,
                                    validator: (value) => value.isEmpty
                                        ? "Email can\'t be empty"
                                        : null,
                                    onFieldSubmitted: (value) =>
                                        _password = value,
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                         filled: true,
                                      hintText: "password",
                                      hintStyle: TextStyle(fontSize: 11.0),
                                      border: InputBorder.none,
                                    ),
                                  ))),
                          Container(
                            padding: EdgeInsets.all(0.0),
                              margin:
                                  EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 0.0),
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
                        ]),
                      ))),

                      //* FACEBOOK LOGIN
                        Container(
                    
                        // color: Color.fromRGBO(0, 100, 215, 1.0),
                            padding: EdgeInsets.all(0.0),
                              margin:
                                  EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
                 /*              decoration: BoxDecoration(
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
                              )), */
                              child: OutlineButton(
                                 color: Color.fromRGBO(0, 100, 215, 1.0),
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    //? This print is for debug
                                    print("Hello");      
                                        
                                
                                  },
                                  child:
                                  ListTile(
                                    leading: Icon(FontAwesomeIcons.facebook,
                                     color: Colors.blue),
                                    title: Text("Sign in with Facebook", style: TextStyle(color: Colors.white, fontSize: 11.0))
                                  )
                                      
                                      )),
                                      //* GOOGLE SIGN IN
                                       Container(
                            padding: EdgeInsets.all(0.0),
                              margin:
                                  EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
                 /*              decoration: BoxDecoration(
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
                              )), */
                              child: OutlineButton(
                                color: Color.fromRGBO(123, 217, 192, 1.0),
                                 
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    //? This print is for debug
                                    print("Hello");    
                                  
                                 sign_in_google();
                                  },
                                  child:
                                  ListTile(
                                    leading: Icon(FontAwesomeIcons.google,
                                    color: Colors.green),
                                    title: Text("Sign in with Google", style: TextStyle(color: Colors.white, fontSize: 11.0))
                                  )
                                      
                                      ))
                     
            ], 
          ),

          //* Title
        ])));
  }



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
}

TextStyle loginButtonStyle = TextStyle(color: Colors.white);

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


