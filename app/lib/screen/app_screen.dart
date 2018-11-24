import 'package:flutter/material.dart';
import 'components/color.dart';
import 'login_screen.dart';
import 'coupon_screen.dart';
import 'package:url_launcher/url_launcher.dart';


// /**
//  * Importing icons from Font Awesome
//  */
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:unicorndial/unicorndial.dart';

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
// import 'friends_screen.dart';
import 'feed_screen.dart';
import 'posts_screen.dart';
import 'price_track_screen.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';


final GoogleSignIn _googleSignIn = GoogleSignIn();
final username_controller = TextEditingController();
final textpost_controller = TextEditingController();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
// /**
//  * EXTERNAL METHODS
//  */
googleLogout() {
  _googleSignIn.signOut();
}

// send the users input from the search bar to the explorer and local deals file
// when the value goes there it will set a global variable that edits the url variable
databasePush() {
  print(username_controller.text);
  // function in the explorer_screen
  searchExplorer(username_controller.text);
  // function in the local_deal_screen
  searchLocal(username_controller.text);
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

  checkSignIn() {
    var user = FirebaseAuth.instance.currentUser();
    if (user == null) {
      print("There are no users currently logged on.");
    } else {
      print(" User currently logged on: $user");
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut().then((user) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var _postButtonItems = List<UnicornButton>();

    _postButtonItems.add(UnicornButton(
        hasLabel: true,
        labelText: "text",
        currentButton: FloatingActionButton(
          heroTag: "text",
          backgroundColor: Color.fromRGBO(232, 77, 124, 1.0),
          mini: true,
          child: Icon(FontAwesomeIcons.commentAlt),
          onPressed: () {
            showDialog(
                context: (context),
                child: SimpleDialog(
                  title: Text("Text Post"),
                  children: <Widget>[
                    TextField(
                      controller: textpost_controller,
                      decoration: InputDecoration(
                          filled: true, labelText: "comment your post here"),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          child: Text("clear"),
                          onPressed: () {},
                        ),
                        FlatButton(
                          child: Text("post"),
                          onPressed: () {
                            // postController(textpost_controller.text);
                            print(textpost_controller.text);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AppScreen()));
                          },
                        )
                      ],
                    )
                  ],
                ));
          },
        )));

    _postButtonItems.add(UnicornButton(
        hasLabel: true,
        labelText: "photo",
        currentButton: FloatingActionButton(
            onPressed: () {},
            heroTag: "photo",
            backgroundColor: Color.fromRGBO(101, 243, 250, 1.0),
            mini: true,
            child: Icon(FontAwesomeIcons.image))));

    _postButtonItems.add(UnicornButton(
        hasLabel: true,
        labelText: "link",
        currentButton: FloatingActionButton(
            onPressed: () {},
            heroTag: "link",
            backgroundColor: Color.fromRGBO(178, 59, 178, 1.0),
            mini: true,
            child: Icon(FontAwesomeIcons.link))));

    return SafeArea(
        minimum: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
                length: 3,
                child: Scaffold(
                    floatingActionButton: UnicornDialer(
                        // backgroundColor:  Color.fromRGBO(224, 41, 97, 0.1),
                        backgroundColor: Colors.transparent,
                        parentButtonBackground: pinkColorScheme,
                        orientation: UnicornOrientation.VERTICAL,
                        parentButton: Icon(CommunityMaterialIcons.message_draw, size: 15.0),
                        childButtons: _postButtonItems),
                    appBar: AppBar(
                      toolbarOpacity: 0.9,
                      bottomOpacity: 0.8,
                      // title: Image(
                      //   image: AssetImage("assets/images/ic_couponitlogo_2.png")
                      // ),
                      // titleSpacing: NavigationToolbar.kMiddleSpacing,
                      centerTitle: true,
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 20.0),
                          Icon(FontAwesomeIcons.bars)
                        ],
                      ),

                      actions: <Widget>[
                        IconButton(
                          onPressed: (){
                            Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen()
                            ));
                          },
                         icon: Icon(Icons.notifications)
                          
                          ),
                        SizedBox(width: 30.0)
                      ],
                      title: Container(
                          width: 300.0,
                          padding: EdgeInsets.all(0.0),
                          color: Colors.white,
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.search),
                            ),
                            title: TextFormField(
                                onFieldSubmitted: databasePush(),
                                controller: username_controller,
                                textInputAction: TextInputAction.go,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    hintText: "search for coupons",
                                    hintStyle: TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: "SFProText"))),
                          )),
                      backgroundColor: pinkColorScheme,
                      bottom: TabBar(
                          indicatorColor: Color.fromRGBO(250, 241, 246, 1.0),
                          indicatorWeight: 6.0,
                          tabs: [
                            Tab(text: "local deals"),
                            Tab(text: "explore"),

                            Tab(text: "posts"),
                            //  Tab(text: "feed"),
                          ]),
                    ),
                    // floatingActionButton: FloatingActionButton(
                    //   elevation: 2.0,
                    //   highlightElevation: 2.0,
                    //   backgroundColor: Color.fromRGBO(221, 0, 102, 1.0),
                    //   onPressed: (){
                    //     scan();
                    //   },
                    //   child: Icon(FontAwesomeIcons.barcode,
                    //   semanticLabel: "scan",),
                    // ),
                    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    bottomNavigationBar: BottomAppBar(
                        shape: CircularNotchedRectangle(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                                color: Colors.black45,
                                icon: Icon(Icons.home),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AppScreen()));
                                }),
                            IconButton(
                                color: Colors.black45,
                                icon: Icon(Icons.store),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PriceTracker()));
                                }),

                            // SCAN BUTTON
                            RaisedButton(
                              color: pinkColorScheme,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              child: Icon(CommunityMaterialIcons.barcode,
                                  size: 32.0, color: Colors.white),
                              onPressed: () {
                                scan();
                              },
                            ),
                            IconButton(
                                color: Colors.black45,
                                icon: Icon(
                                  FontAwesomeIcons.wallet,
                                  size: 20.0,
                                ),
                                onPressed: () {}),
                            IconButton(
                                color: Colors.black45,
                                icon: Icon(Icons.account_box),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                                }),
                          ],
                        )),

                    /**
           * BODY CONTENT
           * * This is where the content from the tab should appear
           */
                    body: TabBarView(children: [
                      LocalDealsScreen(),

                      // Todos: Redo the UI of the new feed(explore)
                      ExploreScreen(),

                      FeedScreen(),
                      // FeedScreen()
                    ])))));
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
      scannedValueCoupon(barcode);

      setState(() => this.barcode = barcode);
      _launchURL(barcode, context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CouponScreen()));
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

_launchURL(urlTest, context) async {
  var url = urlTest;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CouponScreen()));
    // throw 'Could not launch $url';
  }
}
