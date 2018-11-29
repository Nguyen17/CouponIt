import 'package:flutter/material.dart';

/// heartButton Widget
/// @return a filled heart icon when toggle
/// @notes can be expanded to add counter and write to a database
class HeartButton extends StatefulWidget {
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool _isLiked = false;
  void _toggleLiked() {
    setState(() {
      if (!_isLiked) {
        _isLiked = true;
      } else {
        _isLiked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: EdgeInsets.all(0.0),
        child: IconButton(
          icon: (_isLiked
              ? Icon(Icons.favorite, color: Color.fromRGBO(228, 19, 131, 1.0))
              : Icon(Icons.favorite_border,
                  color: Color.fromRGBO(228, 19, 131, 1.0))),
          color: Colors.red[500],
          onPressed: _toggleLiked,
        ),
      )
    ]);
  }
}
