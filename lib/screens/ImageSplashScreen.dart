import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:ichsampleapp/Constant/Constant.dart';

class ImageSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<ImageSplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(SIGNUP_SCREEN);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1500, allowFontScaling: true);
    return MaterialApp(
      home: Scaffold(
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: new Image.asset(
                'assets/splash_background.png',
                width: MediaQueryData.fromWindow(window).size.width,
                height: MediaQueryData.fromWindow(window).size.height,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
