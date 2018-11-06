import 'package:flutter/material.dart';
import 'profile_screen.dart';
/**
 * Importing HTTP Packages
 */
import 'dart:async';

/**
 * Importing UI LIBRARIES
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

/**
 * NOTES:
 * todos: comment the use case scenario
 * todos: line 164 - create facebook and google OAuth buttons
 */

/// Login Screen
/// title:
/// actors:
/// use case:
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  String _email;
  String _password;

  // Create global key to track form state
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  // Create Methods for submiting the form.
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
      // database unique acc id for the profile implementation
      databaseProfileref(user.uid, _email);
      Navigator.of(context).pushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                    backgroundColor: Color.fromRGBO(218, 71, 223, 1.0),
                    child: Icon(Icons.person_add),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up_email');
                    }),
                backgroundColor: Colors.transparent,
                /**
                 * Insert Content Wrapper Here
                 * contains:
                 *  - logo image
                 *  - form fields
                 *  - submit button
                 *  - auth through social media
                 *  - app title
               */
                body: Stack(children: [
                  // INSERT BACKGROUND IMAGE

                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/bgGradient6.jpg")))),

                  ListView(children: [
                    SizedBox(height: 40.0),

                    // INSERT LOGO IMAGE
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 128.0,
                            height: 128.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png")),
                            ))
                      ],
                    ),
                    SizedBox(height: 10.0),

                    // INSERT APP TITLE
                    Text(
                      'Coupon It.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Cookie",
                          fontWeight: FontWeight.w600,
                          fontSize: 44.0,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20.0),

                    // INSERT APP SVG / PNG IMAGE
                    Container(
                      width: 266.0,
                      height: 197.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/images/image5.png"))),
                    ),
                    SizedBox(height: 40.0),

                    /**
                     * FORM FIELDS
                     * - email input
                     * - password input
                     * - submit button
                     */
                    Center(
                        child: Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              width: 275.0,
                              // height: 550.0,

                              /**
                       * Create Column
                       *  - wrapper holds email and password text field inputs
                       *  - and login button
                       */
                              child: Column(children: <Widget>[
                                // Create email field
                                Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    // width: 300.0,
                                    height: 51.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: ListTile(
                                        leading: Icon(Icons.email),
                                        title: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (val) => _email = val,
                                          validator: (value) => value.isEmpty
                                              ? "Email can\'t be empty"
                                              : null,
                                          onFieldSubmitted: (value) =>
                                              _email = value,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            filled: false,
                                            hintText: "email",
                                            hintStyle: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: "SFProText"),
                                            border: InputBorder.none,
                                          ),
                                        ))),
                                // Create password field
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0.0, 20.0, 0.0, 20.0),
                                    // width: 300.0,
                                    height: 51.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: ListTile(
                                        leading: Icon(FontAwesomeIcons.key),
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
                                            filled: false,
                                            hintText: "password",
                                            hintStyle: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: "SFProText"),
                                            border: InputBorder.none,
                                          ),
                                        ))),

                                // Create login button
                                Container(
                                    width: 154.0,
                                    height: 44.0,
                                    margin: EdgeInsets.fromLTRB(
                                        50.0, 20.0, 50.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  16, 62, 102, 1.0),
                                              offset: Offset(1.0, 6.0),
                                              blurRadius: 5.0),
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  197, 37, 144, 1.0),
                                              blurRadius: 10.0)
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            //   Color.fromRGBO(16, 62, 102, 1.0),
                                            // Color.fromRGBO(50, 68, 129, 1.0),
                                            // Color.fromRGBO(97, 68, 147, 1.0),
                                            // Color.fromRGBO(147, 59, 153, 1.0),
                                            // Color.fromRGBO(197, 37, 144, 1.0),
// ---
                                            // Color.fromRGBO(198, 2, 240, 1.0),
                                            // Color.fromRGBO(212, 20, 240, 1.0),
                                            // Color.fromRGBO(224, 34, 239, 1.0),
                                            // Color.fromRGBO(236, 45, 239, 1.0),
                                            // Color.fromRGBO(248, 56, 239, 1.0),

                                            Color.fromRGBO(239, 243, 209, 1.0),
                                            Color.fromRGBO(215, 241, 200, 1.0),
                                            Color.fromRGBO(182, 240, 200, 1.0),
                                            Color.fromRGBO(141, 238, 210, 1.0),
                                            Color.fromRGBO(86, 235, 229, 1.0),
                                          ],
                                          begin: FractionalOffset.topLeft,
                                          end: FractionalOffset.bottomRight,
                                          // stops: [0.2,0.2,0.2,0.2,0.2],
                                          // tileMode: TileMode.mirror
                                        )),

                                    //* Create Account Button
                                    //* creates a new user and send to firebase
                                    child: MaterialButton(
                                        onPressed: () {
                                          //? This print is for debug
                                          // Navigator.pushNamed(context, '/sign_up_email');
                                          _formKey.currentState.save();
                                          userLogin();

                                          // Todos: FIX THIS !! <3
                                        },
                                        child: Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "SFProText",
                                                fontSize: 15.0,
                                                fontWeight:
                                                    FontWeight.w600)))), //penis
                                // Container(
                                //     width: 252.0,
                                //     padding: EdgeInsets.all(0.0),
                                //     margin: EdgeInsets.fromLTRB(
                                //         0.0, 20.0, 0.0, 0.0),
                                //     child: RaisedButton(
                                //         elevation: 3.0,
                                //         padding: EdgeInsets.all(20.0),
                                //         // color: Color.fromRGBO(184, 6, 172, 1.0),
                                //         color:
                                //             Color.fromRGBO(255, 31, 105, 1.0),
                                //         onPressed: () {
                                //           _formKey.currentState.save();
                                //           print(_email);
                                //           userLogin();
                                //         },
                                //         child: Text("continue to app",
                                //             style: TextStyle(
                                //                 color: Colors.white)))),

                                // Create Facebook and Google submit button
                                // - style should be a round button
                                // - solved the challenge of creating a gradient
                                Container(
                                  width: 200.0,
                                  padding: EdgeInsets.all(0.0),
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                  // decoration: BoxDecoration(
                                  //     gradient: LinearGradient(
                                  //   colors: [
                                  //     Color.fromRGBO(239, 243, 209, 1.0),
                                  //     Color.fromRGBO(215, 241, 200, 1.0),
                                  //     Color.fromRGBO(182, 240, 200, 1.0),
                                  //     Color.fromRGBO(141, 238, 210, 1.0),
                                  //     Color.fromRGBO(86, 235, 229, 1.0),
                                  //   ],
                                  //   begin: FractionalOffset.topLeft,
                                  //   end: FractionalOffset.bottomRight,
                                  // )),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      IconButton(
                                          iconSize: 34.0,
                                          color:
                                              Color.fromRGBO(59, 89, 152, 1.0),
                                          onPressed: () {},
                                          icon: Icon(
                                              FontAwesomeIcons.facebookSquare)),
                                      IconButton(
                                          iconSize: 34.0,
                                          color:
                                              Color.fromRGBO(29, 161, 242, 1.0),
                                          onPressed: () {},
                                          icon: Icon(
                                              FontAwesomeIcons.twitterSquare)),
                                      IconButton(
                                          iconSize: 34.0,
                                          color:
                                              Color.fromRGBO(52, 168, 83, 1.0),
                                          onPressed: () {
                                            signInGoogle();

                                            if (_googleSignIn.currentUser !=
                                                null) {
                                              Navigator.pushNamed(
                                                  context, '/home');
                                            } else {
                                              print("Called on null");
                                              Navigator.pushNamed(
                                                  context, '/home');
                                            }

                                            //  Navigator.pushNamed(context, '/home');
                                          },
                                          icon: Icon(FontAwesomeIcons
                                              .googlePlusSquare))
                                    ],
                                  ),
                                  // child: FlatButton(
                                  //     padding: EdgeInsets.all(3.0),
                                  //     color: Colors.transparent,
                                  //     onPressed: () {
                                  //       sign_in_google();
                                  //       Navigator.of(context)
                                  //           .pushNamed('/home');
                                  //     },
                                  //     child: Text("google",
                                  //             style: TextStyle(
                                  //                 fontFamily: 'Kotori',
                                  //                 color: Colors.white,
                                  //                 fontSize: 11.0))))
                                )
                              ]),
                            ))),

                    // SIGN UP
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New to the app?",
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: 14.0,
                                color: Colors.white))
                      ],
                    ),

                    // SizedBox(height: 5.0),
                    Container(
                        width: 252.0,
                        padding: EdgeInsets.all(0.0),
                        margin: EdgeInsets.fromLTRB(120.0, 20.0, 120.0, 0.0),
                        child: RaisedButton(
                            elevation: 3.0,
                            padding: EdgeInsets.all(10.0),
                            // color: Color.fromRGBO(184, 6, 172, 1.0),
                            color: Color.fromRGBO(198, 44, 192, 1.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/sign_up');
                            },
                            child: Text("Sign Up!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "SFProText")))),

                    // SIGN IN AS GUEST
                    Container(
                        width: 200.0,
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.fromLTRB(120.0, 0.0, 120.0, 0.0),
                        child: RaisedButton(
                            color: Color.fromRGBO(51, 44, 198, 1.0),
                            textColor: Colors.white,
                            child: Text(
                              "Sign in as Guest",
                              style: TextStyle(
                                  fontFamily: "SFProText", fontSize: 10.0),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            })),
                    SizedBox(height: 10.0),

                    // =====================================
                  ])
                ]))));
  }

  // /**
  //  * FIREBASE MAIN CODE HERE
  //  */
  Future<FirebaseUser> signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("User is  ${user.displayName}");
    return user;
  }

  /**
   * UNICORDIAL FLOATING ACTION BUTTON
   *  - builds a lists of buttons and display them as vertical options
   *  - init the lists of buttons
   */

}
