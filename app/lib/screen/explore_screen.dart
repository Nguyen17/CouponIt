import 'package:flutter/material.dart';
import 'components/color.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
  var url =
      "https://newsapi.org/v2/everything?q=shopping coupons&from=2018-10-01&sortBy=publishedAt&apiKey=1e6a7dc83456418ca0c38623de7f761b";

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
           
                      Container(
                          //  width: 201.0,
                          //  height: 48.0,

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
                                  maxFontSize: 32.0,
                                  minFontSize: 24.0,
                                  // textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontFamily: 'PlayfairDisplay',
                                      //  fontSize: 21.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10.0),
                              ]))
                        ],
                      )),
                      SizedBox(height: 10.0),

                      Container(
                          width: 350.0,
                          child: AutoSizeText(
                            articles[index]["description"],
                            minFontSize: 12.0,
                            softWrap: true,
                            style: TextStyle(
                              height: 1.25,
                              fontFamily: 'OpenSans',
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                              onPressed: () {
                                articles[index]['url'] == null
                                    ? debugPrint("url not found")
                                    : _launchURL(articles[index]['url']);
                              },
                              // color: Color.fromRGBO(184, 91, 176, 1.0),
                              color: Color.fromRGBO(45, 90, 124, 1.0),
                              child: Text(
                                "Read",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              )),
                          SizedBox(width: 20.0),
                          Icon(Icons.favorite_border),
                          SizedBox(width: 20.0),
                          Icon(Icons.share),
                          SizedBox(width: 20.0),
                          Text(
                            articles[index]["source"]["name"] == null
                                ? "unknown source"
                                : articles[index]["source"]["name"],
                            style: TextStyle(
                                color: Color.fromRGBO(103, 103, 103, 1.0)),
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

  _launchURL(urlTest) async {
    var url = urlTest;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
