import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ichsampleapp/Constant/Constant.dart';
import 'package:ichsampleapp/screens/LoginScreen.dart';
import 'package:ichsampleapp/screens/setpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';

class ActivationCode extends StatefulWidget {

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      /*routes: <String, WidgetBuilder>{
        '/activationcode' : (BuildContext context) => new ActivationCode()
      },*/
      home: new ActivationCode(),
    );
  }

  @override
  _ActivationCodeState createState() => _ActivationCodeState();
}

class _ActivationCodeState extends State<ActivationCode> {

  final _emailVerificationController =  TextEditingController();
  bool emailValidation = false;
  bool loading;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    Size size = MediaQuery
        .of(context)
        .size;
    return new Scaffold
      (
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
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

            child: Stack(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Container(
                          padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
                          child: Text(
                            'Please Check Your Mail For Activation Code',
                            style:
                            TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                      ),

                      Container(
                        child: Stack(
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.fromLTRB(100.0, 50.0, 0.0, 0.0),
                              child: Text(
                                '.',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(

                          padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _emailVerificationController,
                                decoration: InputDecoration(
                                    labelText: 'Enter Verification Code',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    // hintText: 'EMAIL',
                                    // hintStyle: ,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white))),
                              ),
                              SizedBox(height: 50.0),
                              Container(
                                  height: 45.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    shadowColor: Colors.white,
                                    color: Colors.white,
                                    elevation: 7.0,
                                    child: GestureDetector(
                                      child: Center(
                                        child: Text(
                                          'Verify',
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                      onTap: () async {

                                        var connectivityResult = await (Connectivity().checkConnectivity());
                                        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                          // I am connected to a mobile network.
                                          setState(() {
                                            _emailVerificationController.text.isEmpty ? emailValidation = true : emailValidation = false;
                                            loading = true;
                                          });
                                        }
                                        else
                                        {
                                          showInSnackBar("No internet available.Please check your internet connection");
                                        }
                                        SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                        var email = prefs.getString('customerEmail');
                                        pr.show();
                                        var url =
                                            API_URL+'activate-account';

                                        Map<String, dynamic> data = {
                                          'email':email,
                                          'email_verify_code': _emailVerificationController.text,
                                        };

                                        print('URL'+url);
                                        print(data);


                                        final response = await http.post(url,
                                            headers: {
                                              "Accept": "application/json",
                                              "Content-Type": "application/x-www-form-urlencoded"
                                            },
                                            encoding: Encoding.getByName("utf-8"),
                                            body: data).timeout(Duration(seconds: 15));
                                        final int statusCode = response.statusCode;

                                        print(statusCode);

                                        if(statusCode == 200)
                                        {
                                          pr.hide();
                                          loading = false;
                                          var convertDataToJson = json.decode(response.body);
                                          var status = convertDataToJson['status'];
                                          var statusMessage = convertDataToJson['message'];

                                          if(status == true)
                                          {
                                            showInSnackBar(statusMessage);
                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (context) => new SetPassword()));
                                          }
                                          else
                                          {
                                            showInSnackBar(statusMessage);
                                          }
                                        }

                                        else if (statusCode < 200 ||
                                            statusCode > 400 ||
                                            json == null) {
                                          pr.hide();
                                          loading = false;
                                          var convertDataToJson = json.decode(response.body);
                                          var statusMessage = convertDataToJson['message'];
                                          showInSnackBar(statusMessage);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext ctx) =>
                                                      LoginScreen()));
                                          //showInSnackBar("Error while fetching data");
                                          throw new Exception(
                                              "Error while fetching data");
                                        }
                                        else
                                        {
                                          print(statusCode);
                                          pr.show();
                                          loading = false;
                                          var convertDataToJson = json.decode(response.body);
                                          var statusMessage = convertDataToJson['message'];
                                          showInSnackBar(statusMessage);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext ctx) =>
                                                      LoginScreen()));
                                         // showInSnackBar("something went wrong, please try again");
                                        }

                                        setState(() {
                                          loading = false;
                                        });
                                        return response;
                                      },
                                    ),
                                  )
                              ),
                              SizedBox(height: 20.0),
                            ],
                          )),
                    ]
                ),
              ],
            ),
          )
        ],
      ),
    );

  }

  void showInSnackBar(String value) {

    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }
}
