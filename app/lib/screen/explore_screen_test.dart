import 'package:flutter/material.dart';
// import 'components/color.dart';



// /**
//  * Importing UI packages
//  */
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// /**
//  * Importing modules for Http requests 
//  *  - need for 'get' requests
//  *  - need to parse json
//  */
// import 'package:http/http.dart' show get;
// import 'dart:async';
// import 'dart:convert';




class ExploreScreenTest extends StatefulWidget {
    @override
  _ExploreScreenTestState createState() => _ExploreScreenTestState();
}
class _ExploreScreenTestState extends State<ExploreScreenTest> {

// var url = "https://newsapi.org/v2/everything?q=shopping coupons&from=2018-10-01&sortBy=publishedAt&apiKey=1e6a7dc83456418ca0c38623de7f761b";

// var placeholderBlank = "https://via.placeholder.com/600x240";
// var placeholderImage = "https://picsum.photos/600/240/?random";

// Map articleModel;
// List articles;

// bool _isloading = true;

void initState() { 
  super.initState();
  // fetchData();
}

  @override
  Widget build(BuildContext context) {
   
    return 
      
      ListView.builder(
        itemCount: 10,
        itemBuilder:(BuildContext context, int index){
          return Container(
            width: 419.0,
            height: 437.0,
            child:Column(
              children:[
                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment:MainAxisAlignment.center,
                  children:[
                    Image.asset("assets/images/sephora.png",
                    width: 328.0,
                    height: 237.0,
                    fit: BoxFit.contain),
                      SizedBox(height: 10.0),
                Flex(
                   direction: Axis.horizontal,
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width:55.0),
                           Text("Sephora | 20% OFF",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "PlayfairDisplay",
                      fontWeight: FontWeight.w700
                    )
                    )
                      ],
                    )
                  ],
                )
                  ]
                ),
              
              ]
            )
          );
        }
      ,
    );
  }

  // /**
  //  * FUTURE Methods
  //  *  - calls the api and retrieve information
  //  */
//   Future fetchData() async {

//     var res = await get(url);
//     //debugPrint(res.body);
//     articleModel = json.decode(res.body);
//     setState(() {
//           articles = articleModel["articles"];
//         });
//     //print(articleModel);
//     debugPrint(articles.toString());
//     print("articles length: ${articles.length}");
//     _isloading = false;
//   }

// _launchURL(urlTest) async {
//   var url = urlTest;
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

}