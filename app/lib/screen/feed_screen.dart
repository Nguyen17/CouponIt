import 'package:flutter/material.dart';
import 'components/color.dart';
import '../models/postActivity.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:random_color/random_color.dart';

DatabaseReference database =
    FirebaseDatabase.instance.reference().child('post');

String postVals = "";
String postKey;

// will set postvals and post keys, which is the userinfo(key) and their inputs(values)
// ** DEPRECATED **
displayPosts() {
  database.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, values) {
      // havent finished implementing the user who posted stuff, but
      // the data within the database is all displayed
      postVals = postVals + "\n" + (values["text"]);
    });
  });
}

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void initState() {
    super.initState();

    // retrievePost();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        // child: Center(
        //   child: FlatButton(
        //     child: Icon(Icons.add_comment),
        //     onPressed: (){
        //       // Map postMap = json.decode(postActivity[0]);
        //       // print(postMap.runtimeType.toString());
        //       // print(postMap["content"]);
        //       print(postActivity.length);
        //     },
        //   )
        // )

        child: ListView.builder(
      itemCount: postActivity.length,
      itemBuilder: (BuildContext context, int index) {
        Map postMap = json.decode(postActivity[index]);
        RandomColor _randomColor = RandomColor();

        Color _color = _randomColor.randomColor();
        return Card(
            child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: _color, width: 1.0, style: BorderStyle.solid))),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    postMap["author"],
                    style: TextStyle(
                        color: (postMap["author"] == "Guest")
                            ? Colors.grey
                            : Colors.pinkAccent,
                        fontFamily: "SFProText",
                        fontSize: 11.0),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  // Text("wrote",
                  // style: TextStyle(
                  //   fontFamily: "SFProText",
                  //   fontSize: 11.0
                  // ))
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(postMap["content"],
                      textAlign: TextAlign.right,
                      softWrap: true,
                      minFontSize: 14.0,
                      maxFontSize: 21.0,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: "SFProText",
                      ))
                ],
              )
            ],
          ),
        ));
      },
    ));
  }
}
