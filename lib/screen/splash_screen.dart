import 'dart:async';

import 'package:brain_teaser/util/constant.dart';
import 'package:brain_teaser/util/router_path.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void startTimer() {
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(DashBoardScreen);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: kItemSelectBottomNav),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Prepare ",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "for any Test",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
