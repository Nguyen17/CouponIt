import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'login_screen.dart';

// Importing HTTP packages
// import 'dart:async';

// Importing UI packages
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

/**
 * Importing any screen routes
 */
// import 'login_screen_ver2.dart';

/// Welcome Screen
/// title:
/// actors:
/// use case scenario:
initiateDisplayPost() {
  //in feed_screen
  displayPosts();
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // /**
  //  * Global Variables
  //  *  - init starting variable to hold current index count
  //  *  - hold images and data in lists
  //  *  - when a user swipe, increment the image array to change bg and text of app
  //  */
  int titleIndex = 0;
  int bgIndex = 0;
  List<String> bgImage = [
    "assets/images/bgGradient1.jpg",
    "assets/images/bgGradient2.jpg",
    "assets/images/bgGradient3.jpg",
  ];
  List<String> appSubTitle = ["Welcome.", "Find.", "Share."];
  List<String> slideImages = [
    "assets/images/slide1.jpg",
    "assets/images/slide2.jpg",
    "assets/images/slide3.jpg"
  ];

  /// _changeTitle
  /// - invoke function when actor swipe the screen
  /// - changes the bg and text of app
  _changeTitle(index) {
    if (index == 3) {
      index = 0;
    }
    setState(() {
      titleIndex = index;
      bgIndex = index;
    });
    index = index + 1;
  }

  // Creating Pages
  final pages = [
    new PageViewModel(
        pageColor: const Color.fromRGBO(207, 22, 128, 1.0),
        iconImageAssetPath: 'assets/images/ic_couponitlogo_2.png',
        iconColor: null,
        bubbleBackgroundColor: null,
        body: Text(
          'Coupon It. A friendly user app!',
          style: TextStyle(fontFamily: 'SFProText', color: Colors.white,fontSize: 11.0),
        ),
        title: Text(
          'Coupon It.',
          style: TextStyle(fontFamily: 'Cookie', color: Colors.white),
        ),
        // textStyle: TextStyle(fontFamily: 'Cookie', color: Colors.white),
        mainImage: Image.asset(
          'assets/images/slide1.jpg',
          height: 285.0,
          width: 385.0,
          alignment: Alignment.center,
        )),
    new PageViewModel(
        pageColor: const Color.fromRGBO(219, 20, 212, 1.0),
        iconImageAssetPath: 'assets/images/ic_couponitlogo_2.png',
        iconColor: null,
        bubbleBackgroundColor: null,
        body: Text(
          'Find deals that you like and browse :)',
          style: TextStyle(fontFamily: 'SFProText', color: Colors.white,fontSize: 11.0),
        ),
        title: Text(
          'Find.',
           style: TextStyle(fontFamily: 'Cookie', color: Colors.white),
        ),
        // textStyle: TextStyle(fontFamily: 'Cookie', color: Colors.white),
        mainImage: Image.asset(
          'assets/images/slide2.jpg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    new PageViewModel(
        pageColor: const Color.fromRGBO(147, 21, 229, 1.0),
        iconImageAssetPath: 'assets/images/ic_couponitlogo_2.png',
        iconColor: null,
        bubbleBackgroundColor: null,
        body: Text(
          'Share what you find with friends and family.',
          style: TextStyle(fontFamily: 'SFProText', color: Colors.white,fontSize: 11.0),
        ),
        title: Text(
          'Share.',
           style: TextStyle(fontFamily: 'Cookie', color: Colors.white),
        ),
        // textStyle: TextStyle(fontFamily: 'Cookie', color: Colors.white),
        mainImage: Image.asset(
          'assets/images/slide3.jpg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Builder(
          builder: (context) => IntroViewsFlutter(pages, onTapDoneButton: () {
                initiateDisplayPost();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
                // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              skipText: Text("SKIP",
              style:TextStyle(
                fontFamily:"SFProText"
              )),
              doneText: Text("DONE",
              style:TextStyle(
                fontFamily:"SFProText"
              )),
                  showSkipButton: true,
                  pageButtonTextStyles: TextStyle(
                    fontFamily: 'SFProText',
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
        ),
      ),
    );
    // return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: SafeArea(
    //         child: Scaffold(
    //             backgroundColor: Colors.transparent,
    //             body: Stack(children: [
    //               Container(
    //                   decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                           fit: BoxFit.cover,
    //                           image: AssetImage(bgImage[bgIndex])))),
    //               /**
    //                * *Create ListView contains the logo and content
    //                * todos: main content should be draggable between 3 screens
    //                *
    //                */
    //               ListView(children: [
    //                 //* Place logo here
    //                 SizedBox(height: 40.0),
    //                 Flex(
    //                     direction: Axis.horizontal,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Container(
    //                           width: 128.0,
    //                           height: 128.67,
    //                           decoration: BoxDecoration(
    //                             image: DecorationImage(
    //                                 image:
    //                                     AssetImage("assets/images/logo.png")),
    //                           )),
    //                     ]),
    //                 SizedBox(height: 20.0),
    //                 //* Place SUB TITLE HERE
    //                 Container(
    //                     alignment: Alignment.center,
    //                     margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    //                     child: Text(
    //                       appSubTitle[titleIndex],
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(
    //                           fontFamily: "Archivo",
    //                           fontSize: 34.0,
    //                           color:
    //                               // Color.fromRGBO(48, 232, 208, 1.0)),
    //                               Colors.white),
    //                     )),
    //                 SizedBox(height: 40.0),

    //                 //* Place Content wrapper here
    //                 // Container
    //                 //  - box decoration: use to create the bordered rectangle
    //                 //  - Swiper() invoke for user drag interactions
    //                 //    - builds cards when a user swipe
    //                 //      - increment the appTitle and images list to display content
    //                 Center(
    //                     child: Container(
    //                         constraints: BoxConstraints(
    //                             minWidth: 350.0,
    //                             maxWidth: 350.0,
    //                             minHeight: 386.0,
    //                             maxHeight: 386.0),
    //                         decoration: new BoxDecoration(
    //                             borderRadius: new BorderRadius.only(
    //                                 topLeft: const Radius.circular(20.0),
    //                                 topRight: const Radius.circular(20.0),
    //                                 bottomLeft: const Radius.circular(20.0),
    //                                 bottomRight: const Radius.circular(20.0))),
    //                         child: Swiper(
    //                           onIndexChanged: _changeTitle,
    //                           curve: Curves.easeInOut,
    //                           itemBuilder: (BuildContext context, int index) {
    //                             // Builds the cards when a user swipe
    //                             return Container(
    //                               decoration: BoxDecoration(
    //                                   borderRadius: new BorderRadius.only(
    //                                       topLeft: const Radius.circular(20.0),
    //                                       topRight: const Radius.circular(20.0),
    //                                       bottomLeft:
    //                                           const Radius.circular(20.0),
    //                                       bottomRight:
    //                                           const Radius.circular(20.0)),
    //                                   image: DecorationImage(
    //                                       fit: BoxFit.cover,
    //                                       image:
    //                                           AssetImage(slideImages[index]))),
    //                             );
    //                           },

    //                           autoplay: false,
    //                           itemCount: slideImages.length,
    //                           itemWidth: 300.0,
    //                           itemHeight: 400.0,
    //                           indicatorLayout: PageIndicatorLayout.SCALE,
    //                           layout: SwiperLayout.STACK,
    //                           pagination: new SwiperPagination(
    //                               builder: DotSwiperPaginationBuilder(
    //                                   activeColor:
    //                                       Color.fromRGBO(212, 18, 89, 1.0),
    //                                   color:
    //                                       Color.fromRGBO(156, 156, 156, 1.0))),
    //                           // control: new SwiperControl(),
    //                         ))),

    //                 // Create login button
    //                 // - route to the login screen
    //                 loginRoute(context)
    //               ])
    //             ]))));
  }
}

Widget loginRoute(BuildContext context) {
  return Container(
      // width: 74.0,
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.fromLTRB(80.0, 30.0, 80.0, 0.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromRGBO(198, 2, 240, 1.0),
          Color.fromRGBO(212, 20, 240, 1.0),
          Color.fromRGBO(224, 34, 239, 1.0),
          Color.fromRGBO(236, 45, 239, 1.0),
          Color.fromRGBO(248, 56, 239, 1.0),
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
            // initiate post feed screen
            initiateDisplayPost();
            Navigator.pushNamed(context, '/login');
          },
          child: Text("Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: "SFProText"))));
}
