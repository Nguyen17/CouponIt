import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'feed_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

   DatabaseReference database =
      FirebaseDatabase.instance.reference().child('post');



FirebaseUser currentUser;
String textVal;
String postVal;
// data retreived from app_screen
// after user posts after selecting the text option, the iput will be 
// posted in the database and the content will be saved into a variable
// with the variable you can display the contents to the post screen etc..


// uid will be pushed if the current user has not posted anything

  Future<bool> fetchUser() async {
    return FirebaseAuth.instance.currentUser().then((user) {
      if (user == null) {
        return false;
      }
      currentUser = user;
      return true;
    });
  }


postController(String x){



textVal = x;


fetchUser().then((retrievedUser) {
  if (retrievedUser) {
    FirebaseDatabase.instance.reference().child("post").child(currentUser.uid).child('text').set(textVal);
  }
});


// // displayPosts is in the feed_screen page
displayPosts();

}
class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}
class _PostsScreenState extends State<PostsScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("This is a post screen"),
    );
  }
}