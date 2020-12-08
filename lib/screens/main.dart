import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ichsampleapp/Constant/Constant.dart';
import 'package:ichsampleapp/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:ichsampleapp/screens/ImageSplashScreen.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(new Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
        home: new ImageSplashScreen(),

        routes: <String, WidgetBuilder>{
          LOGIN_SCREEN : (BuildContext context) => new LoginScreen()
        },
      )));
}