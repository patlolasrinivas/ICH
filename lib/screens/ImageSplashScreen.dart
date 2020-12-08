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
  Navigator.of(context).pushReplacementNamed(LOGIN_SCREEN);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1500, allowFontScaling: true);
    return MaterialApp(
      home: Scaffold(
        body: new Stack(

          children: <Widget>[

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: new Image.asset(
                    'assets/splash_background.png',
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
            child: Padding(padding:EdgeInsets.only(left: 0.0, right: 0.0, top: 250.0),
            child: Column(
              children:<Widget> [
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/ich-logo.png",
                      width: ScreenUtil.getInstance().setWidth(750),
                      height: ScreenUtil.getInstance().setHeight(500),
                    ),
                  ],
                ),
              ],
            ) ,
            ),
            )
          ],

        ),
      ),
    );
  }
}
