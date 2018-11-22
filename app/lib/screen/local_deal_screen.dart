import 'package:flutter/material.dart';
import 'components/color.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:url_launcher/url_launcher.dart';

/**
 * Importing modules for Http requests 
 *  - need for 'get' requests
 *  - need to parse json
 */
import 'package:http/http.dart' show get;
import 'dart:async' show Future;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

// variable that is concatenated to the URL variable
String searchLocalInput = "local";

// sets the global var searchlocalinput, which concatenates the string in the url var
void searchLocal(String val) {
  searchLocalInput = val;

  return;
}

class LocalDealsScreen extends StatefulWidget {
  @override
  _LocalDealsScreenState createState() => _LocalDealsScreenState();
}

class _LocalDealsScreenState extends State<LocalDealsScreen> {
  // INIT variables to hold api response
  Map dealModel;
  List dealList;

  bool _isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return (_isloading == true)
        ? SpinKitFoldingCube(
            color: pinkColorScheme,
            size: 45.0,
          )
        : StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: dealList.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                onTap: () {
                  _launchURL(dealList[index]['deal']['url']);
                },
                child: Container(
                  child: new Stack(
                    children: <Widget>[
                      coverNetworkImage(dealList[index]['deal']['image_url']),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.all(6.0),
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            child: Column(children: [
                              Text(
                                dealList[index]['deal']['short_title'],
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontFamily: "SFProText"),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(
                  2, index % 5 == 1 || index % 5 == 4 ? 3 : 2);
            },
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
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

  void _launchURL(url) async {
    // print("load url");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // /**
  //  * FUTURE Methods
  //  *  - calls the api and retrieve information
  //  */
  Future fetchData() async {
    // API url
    var url =
        'https://api.discountapi.com/v2/deals?api_key=CqtOTdQe&query=$searchLocalInput&location="las vegas, NV"';

    var res = await get(url);
    dealModel = json.decode(res.body);
    setState(() {
      dealList = dealModel["deals"];
      // print(dealList);
    });
    //print(articleModel);
    print(dealList[0]["deal"]["url"].toString());
    print(dealList.length);
    _isloading = false;
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
