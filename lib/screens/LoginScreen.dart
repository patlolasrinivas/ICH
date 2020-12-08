import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ichsampleapp/screens/activationcode.dart';
import 'package:ichsampleapp/screens/signup.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


ProgressDialog pr;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double percentage = 0.0;
  final myControllerUserName = TextEditingController();
  final myControllerPassword = TextEditingController();
  bool passwordValidation = false;
  bool userNameValidation = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading;


  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
    });
    loading = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
      loading = false;
    });
    myControllerUserName.dispose();
    myControllerPassword.dispose();
    subscription.cancel();
  }

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    Size size = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);


    return new Scaffold(
      key:_scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          WillPopScope(
            onWillPop: _onBackPressed,
            child: Container(),
          ),
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
            child: Padding(
              padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 200.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/ich-logo.png",
                        width: ScreenUtil.getInstance().setWidth(750),
                        height: ScreenUtil.getInstance().setHeight(500),
                      ),
                    ],
                  ),
                  /*SizedBox(
                    height: ScreenUtil.getInstance().setHeight(5),
                  ),*/

                  Container(
                      height: 150.0,
                      padding: const EdgeInsets.all(50.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.white,
                        color: Colors.white,
                        elevation: 7.0,
                        child: GestureDetector(
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                          onTap: () {

                          },
                        ),
                      )
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 0.0,left: 55.0, right: 55.0,),
                    height: 50.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => new SignupPage()));
                        },
                        child:

                        Center(
                          child: Text('Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  // ignore: missing_return
  Future<bool> _onBackPressed() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you sure?",
      desc: "You are going to exit the application!!",
      buttons: [
        DialogButton(
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            exit(0);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}

class Response1 {
  final String authority;

  Response1({this.authority});

  factory Response1.fromJson(Map<String, dynamic> json) {
    return Response1(
      authority: json['authority'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authority': authority,
    };
  }
}
