import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ichsampleapp/Constant/Constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ichsampleapp/screens/LoginScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';



class SetPassword extends StatefulWidget {

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      /*routes: <String, WidgetBuilder>{
        '/SetPassword' : (BuildContext context) => new SetPassword()
      },*/
      home: new SetPassword(),
    );
  }

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

ProgressDialog pr;

class _SetPasswordState extends State<SetPassword> {

  var confirmPass;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _passwordController =  TextEditingController();
  final _confirmpasswordController =  TextEditingController();
  bool passwordValidation = false;
  bool confirmpasswordValidation = false;
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    return new
    Scaffold
      (
      key: _form,
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
                          'Please Set Your Password',
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
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                        errorText: passwordValidation ? 'Password Can\'t Be Empty' : null,
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 12.0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white))),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                               controller: _confirmpasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    errorText: confirmpasswordValidation ? 'Confirm Password Can\'t Be Empty' : null,
                                    // hintText: 'EMAIL',
                                    // hintStyle: ,
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 12.0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white))),
                              ),
                              SizedBox(height: 50.0),
                              Container(
                                  height: 45.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    shadowColor: Colors.white,
                                    color: Colors.white,
                                    elevation: 7.0,
                                    child: GestureDetector(
                                      child: Center(
                                        child: Text(
                                          'Submit',
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
                                            _passwordController.text.isEmpty ? passwordValidation = true : passwordValidation = false;
                                            _confirmpasswordController.text.isEmpty ? confirmpasswordValidation = true : confirmpasswordValidation = false;
                                            loading = true;
                                          });
                                        }

                                        else
                                        {
                                        showInSnackBar("No internet available.Please check your internet connection");
                                        }

                                      //  if (_form.currentState.validate()) {
                                          pr.show();
                                          SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          var customerID = prefs.getString('customerID');
                                          var url =
                                              API_URL+'set_password';

                                          Map<String, dynamic> data = {
                                            'user_id': customerID,
                                            'password': _passwordController.text,
                                            'cpassword': _confirmpasswordController.text,
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

                                          if(statusCode == 200)
                                          {
                                            pr.hide();
                                            loading = false;
                                            var convertDataToJson = json.decode(response.body);
                                            var status = convertDataToJson['status'];
                                            var statusMessage = convertDataToJson['message'];
                                            var customer_id = convertDataToJson['customer_id'];
                                            var user_reward_points = convertDataToJson['user_reward_points'];
                                            var user_money = convertDataToJson['user_money'];
                                            var user_money_type = convertDataToJson['user_money_type'];
                                            if(status == true)
                                            {
                                              showInSnackBar(statusMessage);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext ctx) =>
                                                          LoginScreen()));
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
                                            showInSnackBar("Error while fetching data");
                                            throw new Exception(
                                                "Error while fetching data");
                                          }
                                          else
                                          {
                                            print(statusCode);
                                            pr.hide();
                                            loading = false;
                                            showInSnackBar("something went wrong, please try again");
                                          }
                                          setState(() {
                                            loading = false;
                                          });
                                          return response;
                                      //  }
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
