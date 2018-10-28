import 'package:flutter/material.dart';
import 'components/color.dart';
import 'coupon_screen.dart';

// /**
//  * Importing icons from Font Awesome
//  */
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// /**
//  * Importing Modules for Firebase
//  */
import 'package:firebase_auth/firebase_auth.dart';

// /**
//  * Importing Google Modules
//  */
import 'package:google_sign_in/google_sign_in.dart';
// /** 
//  * Importing the Barcode Scan Module
//  * * REFER TO DOCUMENTATION
//  * * - https://pub.dartlang.org/packages/barcode_scan#-readme-tab-
//  */
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

// /** 
//  * Importing dart libraries
//  * - dart:async 
//  *    - handles promises function
//  *    - also needs to store http requests and responses
//  */
import 'dart:async';



// /** 
//  * Importing Any necessary screens
//  */
import 'explore_screen.dart';
import 'local_deal_screen.dart';
import 'friends_screen.dart';
import 'feed_screen.dart';




final GoogleSignIn _googleSignIn = GoogleSignIn();

// /** 
//  * EXTERNAL METHODS
//  */
googleLogout() {
  _googleSignIn.signOut();
}




class AppScreen extends StatefulWidget {
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  // This is a variables that holds the return value of the Scan method
   String barcode = '';


  @override
  initState() {
    super.initState();
    checkSignIn();
  }

  checkSignIn(){
    var user = FirebaseAuth.instance.currentUser();
    if(user == null) {
      print("There are no users currently logged on.");
    } else{
      print(" User currently logged on: $user");
    }


  }

  signOut() {
    FirebaseAuth.instance.signOut().then((user) {
      Navigator.of(context).pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
          appBar: AppBar(
            // title: Image(
            //   image: AssetImage("assets/images/ic_couponitlogo_2.png")
            // ),
            // titleSpacing: NavigationToolbar.kMiddleSpacing,
            leading: Image(
              image: AssetImage("assets/images/ic_couponitlogo_2.png")
            ),
            actions: <Widget>[
              // Icon(Icons.shopping_cart)
            ],
            title: Container(
              // width: 200.0,
           
              alignment: Alignment.center,
              color: Colors.white,
              child: ListTile(
              leading: Icon(Icons.search),
              title: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: "search for coupons"
                )
              )
            ),
            ) ,
            backgroundColor: pinkColorScheme,
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(250, 241, 246, 1.0),
              indicatorWeight: 6.0,
              tabs:[
                Tab(text: "local deals"),
                Tab(text: "explore"),
                 
                  Tab(text: "friends"),
                  //  Tab(text: "feed"),
              
              ]
            ),
            ),
          bottomNavigationBar: BottomNavigationBar(
           
           fixedColor: Colors.black45, 
            iconSize: 21.0, items: [
            /** 
             * Todo: CREATE 4-5 items of navigation
             */
      
            // BottomNavigationBarItem(
            //   title: Text("search"),
            //   icon: IconButton(
            //       color: Colors.black45,
            //       icon: Icon(FontAwesomeIcons.search),
            //       onPressed: () {}),
            // ),
            BottomNavigationBarItem(
              title: Text("menu"),
              icon: IconButton(
                  color: Colors.black45,
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {}),
            ),
            BottomNavigationBarItem(
              title: Text("scan"),
              icon: IconButton(
                  color: Colors.black45,
                  icon: Icon(FontAwesomeIcons.barcode),

                  // Todos: Implement scan
                  onPressed: () {
                    scan();
                  }),
            ),
            // BottomNavigationBarItem(
            //   title: Text("friends"),
            //   icon: IconButton(
            //       icon: Icon(Icons.people),
            //       onPressed: () {

            //       }),
            // ),
            BottomNavigationBarItem(
              title: Text("Profile"),
              icon: IconButton(
                  color: Colors.black45,
                  icon: Icon(Icons.account_box),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                    // sign_out();
                    // google_logout();
                  }),
            ),
          ]),

          /**
           * BODY CONTENT
           * * This is where the content from the tab should appear
           */
          body: TabBarView(
            children:[
              LocalDealsScreen(),
              ExploreScreen(),
              
              FriendsScreen(),
              FeedScreen()
            ]
          )

        )
        ))
    );
  }

// /**
//  * Scan METHOD
//  * @This is a method of AppScreen class Widget
//  * @learn about future and promise
//  * refer to barcode scan documentations
//  */
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      scanned_value(barcode);
      setState(() => this.barcode = barcode);

      Navigator.pushNamed(context, '/coupon');
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
} // End of AppScreen CLASS
