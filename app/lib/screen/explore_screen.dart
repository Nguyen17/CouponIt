import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * Importing modules for Http requests 
 *  - need for 'get' requests
 *  - need to parse json
 */
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';

import '../models/article_model.dart';

class ExploreScreen extends StatefulWidget {
    @override
  _ExploreScreenState createState() => _ExploreScreenState();
}
class _ExploreScreenState extends State<ExploreScreen> {

var URL = "https://newsapi.org/v2/everything?q=grocery coupons&from=2018-10-01&sortBy=publishedAt&apiKey=1e6a7dc83456418ca0c38623de7f761b";

var placeholder_blank = "https://via.placeholder.com/600x240";
var placeholder_image = "https://picsum.photos/600/240/?random";

Map articleModel;
List articles;

void initState() { 
  super.initState();
  fetchData();
}

  @override
  Widget build(BuildContext context) {
    return 
      ListView.builder(
        itemCount: articles == null ? 0: articles.length,
        itemBuilder:(BuildContext context, int index){
          return Card(
             child:Container(
               padding: EdgeInsets.all(16.0),
               child:  Column(
               children: <Widget>[
              //  CircleAvatar(
              //    radius: 40.0,
              //    backgroundImage: NetworkImage(articles[index]["urlToImage"]),
                 
              //  ),
              Image.network(articles[index]["urlToImage"] == null ? placeholder_image: articles[index]["urlToImage"] ,
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
                    _launchURL(articles[index]['url']);
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




  /**
   * FUTURE Methods
   *  - calls the api and retrieve information
   */
  Future fetchData() async {

    var res = await get(URL);
    //debugPrint(res.body);
    articleModel = json.decode(res.body);
    setState(() {
          articles = articleModel["articles"];
        });
    //print(articleModel);
    debugPrint(articles.toString());
    print("articles length: ${articles.length}");
  }

_launchURL(url_test) async {
  var url = url_test;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}