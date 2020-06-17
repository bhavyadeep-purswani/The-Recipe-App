import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lime[500],
        accentColor: Colors.green[500],
        primaryColorDark: Colors.lime[700],
        primaryColorLight: Colors.lime[100],
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/splashPic.png",
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "The Recipe App",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Dancing Script',
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
