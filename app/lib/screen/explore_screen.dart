import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:share/share.dart';

/**
 * Importing UI packages
 */
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * Importing modules for Http requests 
 *  - need for 'get' requests
 *  - need to parse json
 */
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  /**
   * Creating necessary variables
   *  - url
   *    - hold the location of where the api call takes place
   *    - pass in search input here
   * 
   *  - additional components
   *    - such as placeholder variables
   */
  var url =
      "https://newsapi.org/v2/everything?q=shopping coupons&from=2018-11-01&sortBy=publishedAt&apiKey=1e6a7dc83456418ca0c38623de7f761b";

  var placeholderBlank = "https://via.placeholder.com/600x240";
  var placeholderLogo =
      "https://firebasestorage.googleapis.com/v0/b/projectcouponit.appspot.com/o/couponit_logo.png?alt=media&token=fb7ec269-1fdb-4588-8312-48a572014767";
  var placeholderImage = "https://picsum.photos/600/240/?random";

  Map articleModel;
  List articles;

  bool _isloading = true;

  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    /** 
     * While component is rendering and calling api requests
     *  - return loading indicator while retrieving data
     */
    return (_isloading == true)
        ? SpinKitThreeBounce(
            color: pinkColorScheme,
            size: 45.0,
          )
        : ListView.builder(
            itemCount: articles == null ? 0 : articles.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2.0,
                child: Container(
                    //  padding: EdgeInsets.all(16.0),

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                      // Create Card Image
                      Image.network(
                        (articles[index]["urlToImage"] == "" ||
                                articles[index]["urlToImage"] == null)
                            ? placeholderLogo
                            : articles[index]["urlToImage"],
                        width: 600.0,
                        height: 240.0,
                        gaplessPlayback: true,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20.0),

                      // Create Title
                      Container(
                

                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 350.0,
                              //  height: 148.0,
                              child: Column(children: [
                                AutoSizeText(
                                  articles[index]["title"],
                                  //  overflow: TextOverflow.fade,
                                  maxFontSize: 24.0,
                                  minFontSize: 21.0,
                                  // textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontFamily: 'SFProText',
                                      //  fontSize: 17.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10.0),
                              ]))
                        ],
                      )),
                      SizedBox(height: 10.0),

                      // Create description
                      Container(
                          width: 350.0,
                          child: AutoSizeText(
                            articles[index]["description"],
                            minFontSize: 11.0,
                            softWrap: true,
                            style: TextStyle(
                              height: 1.25,
                              fontSize: 12.0,
                              fontFamily: 'SFProText',
                            ),
                          )),
                      SizedBox(height: 20.0),

                      // Create a row of components
                      // holds buttong, favorite, and share features
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 20.0),
                          MaterialButton(
                              onPressed: () {
                                articles[index]['url'] == null
                                    ? debugPrint("url not found")
                                    : _launchURL(articles[index]['url']);
                              },
                              // color: Color.fromRGBO(184, 91, 176, 1.0),
                              color: Color.fromRGBO(164, 46, 109, 1.0),
                              child: Text(
                                "Read",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1.0),
                                    fontSize: 11.0,
                                    fontFamily: "SFProText"),
                              )),
                          SizedBox(width: 20.0),
                          Icon(Icons.favorite_border,
                              color: Color.fromRGBO(211, 101, 160, 1.0)),
                          SizedBox(width: 10.0),
                          IconButton(
                            splashColor: Color.fromRGBO(217, 121, 172, 1.0),
                            highlightColor: Color.fromRGBO(200, 62, 135, 1.0),
                            icon: Icon(FontAwesomeIcons.shareAlt,
                                color: Color.fromRGBO(100, 159, 211, 0.7)),
                            onPressed: () {
                              Share.share(articles[index]['url']);
                            },
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            articles[index]["source"]["name"] == null
                                ? "unknown source"
                                : articles[index]["source"]["name"],
                            style: TextStyle(
                                color: Color.fromRGBO(103, 103, 103, 1.0),
                                fontSize: 13.0,
                                fontFamily: "SFProText"),
                          ),
                          SizedBox(width: 20.0),
                        ],
                      ),
                      SizedBox(height: 20.0),
                    ])),
              );
            },
          );
  }

  // /**
  //  * FUTURE Methods
  //  *  - calls the api and retrieve information
  //  */
  Future fetchData() async {
    var res = await get(url);
    //debugPrint(res.body);
    articleModel = json.decode(res.body);
    setState(() {
      articles = articleModel["articles"];
    });
    //print(articleModel);
    debugPrint(articles.toString());
    print("articles length: ${articles.length}");
    _isloading = false;
  }

  /**
   * _luanchURL method
   *  @returns link user to the source site
   */
  _launchURL(urlTest) async {
    var url = urlTest;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
