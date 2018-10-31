import 'package:flutter/material.dart';
import 'components/color.dart';


// /**
//  * Importing Modules for Firebase
//  */
import 'package:firebase_auth/firebase_auth.dart';

// /**
//  * Importing Google Modules
//  */
import 'package:google_sign_in/google_sign_in.dart';
// /** 
import 'package:firebase_database/firebase_database.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

DatabaseReference database = FirebaseDatabase.instance.reference();

// /** 
//  * EXTERNAL METHODS
//  */
googleLogout() {
  _googleSignIn.signOut();
}

class AccountSettingsScreen extends StatefulWidget {
  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String username = 'Krusty Kreme';
  String firstName = 'Jon';
  String lastName = 'Doe';

  bool enableUpdateProfileButton = false;

  void enableProfileUpdate() {
    setState(() {
      enableUpdateProfileButton = true;
    });
  }

  void disableProfileUpdate() {
    setState(() {
      enableUpdateProfileButton = false;
    });
  }

  void checkIfTextFieldsAreEmpty() {
    if (usernameController.text == '' &&
        firstNameController.text == '' &&
        lastNameController.text == '') {
      disableProfileUpdate();
    } else {
      enableProfileUpdate();
    }
  }

  void updateAccountFromTextField() {
    username = usernameController.text != '' ? usernameController.text : username;
    firstName = firstNameController.text != '' ? firstNameController.text : firstName;
    lastName = lastNameController.text != '' ? lastNameController.text : lastName;
  }

  void clearTextFields() {
    usernameController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Account Settings'),
            backgroundColor: purpleColorScheme,
          ),
          body: new ListView(
            children: <Widget>[
              new Container(height: 30.0),
              settingsColumn(),
              new Container(height: 150.0),
              buttonRow(),
            ],
          )),
    );
  }

  Widget settingsColumn() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        settingsRow('Username', username, usernameController),
        settingsRow('First Name', firstName, firstNameController),
        settingsRow('Last Name', lastName, lastNameController),
      ],
    );
  }

  Widget settingsRow(
      String title, String hint, TextEditingController controller) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 80.0,
            child: new Text(
              '$title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: new TextField(
                controller: controller,
                onChanged: (text) {
                  checkIfTextFieldsAreEmpty();
                },
                style: new TextStyle(
                  color: Colors.black,
                ),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(4.0),
                  fillColor: Colors.white,
                  filled: true,
                  border: new OutlineInputBorder(),
                  hintText: '$hint',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonRow() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new MaterialButton(
          height: 40.0,
          minWidth: 170.0,
          color: enableUpdateProfileButton ? Colors.green : Colors.grey,
          textColor: Colors.white,
          child: new Text("Update Profile"),
          onPressed: enableUpdateProfileButton ? () {
            // do someting
            print('Fake debug: Update Profile');
            updateAccountFromTextField();
            clearTextFields();
            disableProfileUpdate();
          } : null,
          splashColor: Colors.redAccent,
        ),
        new MaterialButton(
          height: 40.0,
          minWidth: 170.0,
          color: purpleColorScheme,
          textColor: Colors.white,
          child: new Text("Sign Out"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((user) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
                });
                _googleSignIn.signOut();
          },
          splashColor: Colors.redAccent,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
