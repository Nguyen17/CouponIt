import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
   DatabaseReference database =
      FirebaseDatabase.instance.reference().child('post');


String postVals = "";
String postKey;


// will set postvals and post keys, which is the userinfo(key) and their inputs(values)
displayPosts(){
database.once().then((DataSnapshot snapshot){
  Map<dynamic, dynamic> values=snapshot.value;
     values.forEach((key,values) {
       // havent finished implementing the user who posted stuff, but 
       // the data within the database is all displayed
      postVals = postVals+"\n"+(values["text"]);
    });
 });


}


class FeedScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Text(postVals),
      
    );
  }
}