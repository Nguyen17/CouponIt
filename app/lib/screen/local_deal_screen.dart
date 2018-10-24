import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

/**
 * Importing modules for Http requests 
 *  - need for 'get' requests
 *  - need to parse json
 */
// import 'package:http/http.dart' show get;
// import 'dart:async' show Future;
import 'dart:convert';

class LocalDealsScreen extends StatefulWidget {
  @override
  _LocalDealsScreenState createState() => _LocalDealsScreenState();
}

class _LocalDealsScreenState extends State<LocalDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        // Use future builder and DefaultAssetBundle to load the local JSON file
        child: new FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/data/local_deals.json'),
          builder: (context, snapshot) {
            // Decode the JSON
            var new_data = json.decode(snapshot.data.toString());

            return new ListView.builder(
              // Build the ListView
              itemCount: new_data == null ? 0 : new_data["deals"].length,
              itemBuilder: (BuildContext context, int index) {
                print(new_data);

                return new Card(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text(new_data["deals"][index]["deal"]["title"]),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
