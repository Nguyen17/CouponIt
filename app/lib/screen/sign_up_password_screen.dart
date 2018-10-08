import 'package:flutter/material.dart';
import 'sign_up_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

String _password;
String _email;

void saveEmail(x) {
  _email = x;
}

class SignUpPassword extends StatefulWidget {
  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
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
    // if credentials are correct we will jump to the home page
    print(_email+_password);
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        Navigator.of(
                context) // route to home and remove routes (clear the stack)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
  

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
                  Positioned(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(45.0, 96.0, 0.0, 40.0),
                          child: Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Kotori",
                                  fontSize: 44.0,
                                  fontWeight: FontWeight.w700)))),
                  Positioned(
                      child: Container(
                    width: 155.0,
                    margin: EdgeInsets.fromLTRB(45.0, 224.0, 0.0, 40.0),
                    child: Text("Enter a password.",
                        style: TextStyle(
                            fontFamily: "Kotori",
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                  )),
                  Positioned(
                      child: Container(
                          width: 290.0,
                          margin: EdgeInsets.fromLTRB(45.0, 403.0, 0.0, 40.0),
                          child: Form(
                              child: Column(children: <Widget>[
                            TextFormField(
                               validator: (value) => value.isEmpty
                                    ? "Email can\'t be empty"
                                    : null,
                                onFieldSubmitted: (value) => _password = value,   
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  labelText: "password",
                                  fillColor: Colors.white),
                            )
                          ])))),

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
                                  validateSubmit();
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
