import 'package:flutter/material.dart';
import 'components/color.dart';



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

var url = "https://newsapi.org/v2/everything?q=shopping coupons&from=2018-10-01&sortBy=publishedAt&apiKey=1e6a7dc83456418ca0c38623de7f761b";

var placeholderBlank = "https://via.placeholder.com/600x240";
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
   
    return 
      (_isloading == true) ? SpinKitThreeBounce(color: pinkColorScheme, size: 45.0,) :
      ListView.builder(
        itemCount: articles == null ? 0: articles.length,
        itemBuilder:(BuildContext context, int index){
          return Card(
             child:Container(
               padding: EdgeInsets.all(16.0),
               child:  Column(
               children: <Widget>[
              Image.network((articles[index]["urlToImage"] == null || articles[index]["urlToImage"] =="") ? placeholderBlank: articles[index]["urlToImage"] ,
               width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(articles[index]["publishedAt"]),
                 
                ],
              ),
               SizedBox(height: 20.0),
               Text(articles[index]["title"],
               softWrap: true,
               style: TextStyle(
                 fontFamily: 'Kotori',
                 fontSize: 18.0,
                 fontWeight: FontWeight.w700
               ),),
                SizedBox(height: 10.0),
                Text(articles[index]["author"] == null ? "unknown author" : articles[index]["author"] ),
                SizedBox(height: 20.0),
               Text(articles[index]["description"],
               softWrap: true,
               style: TextStyle(
                 height: 1.25,
                 fontFamily: 'Kotori',
                 fontSize: 12.0,
                
               ),),
                SizedBox(height: 20.0),
                MaterialButton(
                  onPressed: (){
                    articles[index]['url'] == null ? debugPrint("url not found") : _launchURL(articles[index]['url']);
                  },
                  color: Color.fromRGBO(184, 91, 176, 1.0),
                  child: Text("Read", style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1.0)
                  ),)

                )
               ]
             )
             ),
          );
        }
      ,
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