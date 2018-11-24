import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginScreenDemo extends StatefulWidget {
  _LoginScreenDemoState createState() => _LoginScreenDemoState();
}

class _LoginScreenDemoState extends State<LoginScreenDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromRGBO(255, 0, 154, 0.8),
          body: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                width: 375.0,
                height: 360.0,
                child: Container(
                  width: 270.0,
                  height: 118.0,
                  child: Text("Hi, please login to your account.",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SFProText",
                          fontWeight: FontWeight.w500,
                          fontSize: 44.0)),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    title: Container(
                      constraints:
                          BoxConstraints(minWidth: 167.0, maxWidth: 167.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Nametheuser@domain.com",
                              hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: "SFProText"))),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    title: Container(
                      constraints:
                          BoxConstraints(minWidth: 167.0, maxWidth: 167.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "**********",
                              hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: "SFProText"))),
                    ),
                  )),
                   SizedBox(height: 20.0),
                    Container(
                                    width: 154.0,
                                    height: 44.0,
                                    margin: EdgeInsets.fromLTRB(
                                        50.0, 20.0, 50.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        // boxShadow: <BoxShadow>[
                                        //   BoxShadow(
                                        //       color:  Color.fromRGBO(239, 243, 209, 1.0),
                                        //       offset: Offset(0.0, 2.0),
                                        //       blurRadius: 2.0),
                                        //   BoxShadow(
                                        //       color:    Color.fromRGBO(86, 235, 229, 1.0),
                                        //       offset: Offset(1.0,10.0),
                                        //       blurRadius: 20.0)
                                        // ],
                                        gradient: LinearGradient(
                                          colors: [
//                                               Color.fromRGBO(16, 62, 102, 1.0),
//                                             Color.fromRGBO(50, 68, 129, 1.0),
//                                             Color.fromRGBO(97, 68, 147, 1.0),
//                                             Color.fromRGBO(147, 59, 153, 1.0),
//                                             Color.fromRGBO(197, 37, 144, 1.0),
// // ---
//                                             Color.fromRGBO(198, 2, 240, 1.0),
//                                             Color.fromRGBO(212, 20, 240, 1.0),
//                                             Color.fromRGBO(224, 34, 239, 1.0),
//                                             Color.fromRGBO(236, 45, 239, 1.0),
//                                             Color.fromRGBO(248, 56, 239, 1.0),

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
                                        elevation: 2.0,
                                        onPressed: () {
                                          //? This print is for debug
                                          // Navigator.pushNamed(context, '/sign_up_email');
                                          // _formKey.currentState.save();
                                          // userLogin();

                                          // Todos: FIX THIS !! <3
                                        },
                                        child: Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "SFProText",
                                                fontSize: 15.0,
                                                fontWeight:
                                                    FontWeight.w600)))),
  SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                // child: FacebookSignInButton(onPressed: (){},),
                child:     SignInButton(
                    Buttons.Facebook,
                    onPressed:(){}
                  )
              ),
                   Container(
                margin: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
                child:    GoogleSignInButton(onPressed: (){},)
              )
            ],
          )),
    );
  }
}
