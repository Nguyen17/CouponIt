import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
/* 
  Import necessary components

 */

/**
 * 
 * LoginScreenUI
 * * This is the container that have title, email and password input fields
 * ! Needs to center the components
 */

/**
 * External components for styling
 * 
 * ==============================================
 */

class LoginScreen extends StatefulWidget {
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateSave() {
    // if the credentials are correct then we can progress in authenticating the user
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      return true;
    } else {
      return false;
    }
  }

  void validateSubmit() async {

        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print('signed in: ${user.uid}');
        Navigator.of(
                context) // route to home and remove routes (clear the stack)
            .pushNamedAndRemoveUntil('/sign_up_email', (Route<dynamic> route) => false);

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
                Navigator.pushNamed(context, '/sign_up_email');
              }),

          //* Contains blurred background and main login ui
          // ? Will the form work
          //! Might need to replace the widgets with the full code
          //! in order to access form context
          body: Stack(children: <Widget>[
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bg2.jpg'))),
            )),
            Center(
                child: Container(
                    padding: EdgeInsets.all(5.0),
                    width: 300.0,
                    height: 500.0,
                                              
                    child: ListView(children: <Widget>[
                      Container(
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
                          )),
                      Container(
       
                          margin: EdgeInsets.fromLTRB(5.0, 44.0, 5.0, 10.0),
                          color: Colors.white,
                          // width: 290.0,
                          height: 51.0,
                          child: ListTile(
                              leading: Icon(Icons.email),
                              title: TextFormField(
                                onFieldSubmitted: (value) => _email = value,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "email",
                                  hintStyle: TextStyle(fontSize: 11.0),
                                  border: InputBorder.none,
                                ),
                              ))),
                      Container(                        
                          margin: EdgeInsets.fromLTRB(5.0, 16.0, 5.0, 20.0),
                          color: Colors.white,
                           
                          // width: 290.0,
                          height: 51.0,
                          child: ListTile(
                              leading: Icon(Icons.lock_outline),
                              title: TextFormField(
     
                                onFieldSubmitted: (chicken) => _password = chicken,
                                textAlign: TextAlign.center,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "password",
                                  hintStyle: TextStyle(fontSize: 11.0),
                                  border: InputBorder.none,
                                ),
                              ))),
                      Container(
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
                              onPressed:(){
                                print(_email+_password);
                                validateSubmit();
                            

                              }, 
                              
                              child: Text("Login", style: loginButtonStyle))),
                    ])))
          ])),
    ));
  }
}

/** 
 * Sign Up Email Components
 *
 * ================================= 
 */

/** 
 * LoginBg
 * @contains the blurred image background
 */

TextStyle loginButtonStyle = TextStyle(color: Colors.white);
