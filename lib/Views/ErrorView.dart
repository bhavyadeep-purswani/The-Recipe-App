import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String text;

  const ErrorView({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? "images/sad_white.png"
                : "images/sad_black.png",
            width: 150,
            height: 150,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
