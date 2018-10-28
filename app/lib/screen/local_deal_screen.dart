import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      padding: EdgeInsets.all(8.0),
      child: new Center(
        // Use future builder and DefaultAssetBundle to load the local JSON file
        child: new FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/data/local_deals.json'),
          builder: (context, snapshot) {
            // Decode the JSON
            var newData = json.decode(snapshot.data.toString());
            var deals = newData == null ? [] : newData['deals'];
            return (deals.length == 0) ? SpinKitThreeBounce(color: Colors.green) :
           new StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: deals.length,
              itemBuilder: (context, index) {
                return new Container(
                    color: Colors.green,
                    child: new Stack(
                      children: <Widget>[
                        coverNetworkImage(deals[index]['deal']['image_url']),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.all(6.0),
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                              child: Column(children: [
                                Text(
                                  deals[index]['deal']['short_title'],
                                  style: new TextStyle(color: Colors.white),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ));
              },
              staggeredTileBuilder: (index) {
                return new StaggeredTile.count(
                    2, index % 5 == 1 || index % 5 == 4 ? 3 : 2);
              },
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
          },
        ),
      ),
    );
  }

  Widget coverNetworkImage(String url) {
    return new Image.network(
      url,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }
}

// return new ListView.builder(
//   // Build the ListView
//   itemCount: new_data == null ? 0 : new_data["deals"].length,
//   itemBuilder: (BuildContext context, int index) {
//     print(new_data);

//     return new Card(
//       child: new Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           new Text(new_data["deals"][index]["deal"]["title"]),
//         ],
//       ),
//     );
//   },
// );
