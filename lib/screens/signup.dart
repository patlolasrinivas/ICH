import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ichsampleapp/Constant/Constant.dart';
import 'package:ichsampleapp/models/CountryService.dart';
import 'package:http/http.dart' as http;
import 'package:ichsampleapp/models/countries.dart';
import 'dart:convert';
import 'package:ichsampleapp/models/countriesList.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'activationcode.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class SignupPage extends StatefulWidget {

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/activationcode' : (BuildContext context) => new ActivationCode()
      },
      home: new SignupPage(),
    );
  }

  @override
  _SignupPageState createState() => _SignupPageState();
}

ProgressDialog pr;

class _SignupPageState extends State<SignupPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CountriesList _records = new CountriesList();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Countries>> key = new GlobalKey();
  final _nameController =  TextEditingController();
  final _emailController =  TextEditingController();
  final _mobileNumberController =  TextEditingController();
  final _countryNameController =  TextEditingController();
  bool nameValidation = false;
  bool emailValidation = false;
  bool mobileValidation = false;
  bool countryNameValidation = false;
  bool loading;


  void _loadCountries() async {
    CountriesList records = await CountryService().getCountries();
    Countries record;
    setState(() {
      for (record in records.records) {
        this._records.records.add(record);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _records.records = new List();
    _loadCountries();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
     // loading = false;
    });
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _countryNameController.dispose();
   // subscription.cancel();
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
    return new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                            child: Text(
                              'Signup',
                              style:
                              TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(200.0, 125.0, 0.0, 0.0),
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
                              controller: _nameController,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                      errorText: nameValidation ? 'Name Can\'t Be Empty' : null,
                                      hintText: 'Name',
                                      hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                      focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              controller: _emailController,

                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                  errorText: emailValidation ? 'Invalid Email Format' : null,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green)
                                  )
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  searchTextField = AutoCompleteTextField<Countries>(
                                      style: new TextStyle(color: Colors.black, fontSize: 16.0),
                                      controller: _countryNameController,
                                      decoration: new InputDecoration(
                                          suffixIcon: Container(
                                            width: 85.0,
                                            height: 60.0,
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                          filled: true,
                                          errorText: countryNameValidation ? 'County Name Can\'t Be Empty' : null,
                                          hintText: 'Search Country Name',
                                          hintStyle: TextStyle(color: Colors.black)),
                                      itemSubmitted: (item) {
                                        setState(() => searchTextField.textField.controller.text =
                                            item.name);
                                      },
                                      clearOnSubmit: false,
                                      key: key,
                                      suggestions: _records.records,
                                      itemBuilder: (context, item) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(item.name,
                                              style: TextStyle(
                                                  fontSize: 16.0
                                              ),),
                                          ],
                                        );
                                      },
                                      itemSorter: (a, b) {
                                        return a.name.compareTo(b.name);
                                      },
                                      itemFilter: (item, query) {
                                        return item.name
                                            .toLowerCase()
                                            .startsWith(query.toLowerCase());
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              controller: _mobileNumberController,
                              decoration: InputDecoration(
                                  labelText: 'Mobile Number',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                  errorText: mobileValidation ? 'Mobile Number Can\'t Be Empty' : null,
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green)
                                  )
                              ),
                            ),

                            SizedBox(height: 15.0),

                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Referal Code (Optional)',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green)
                                  )
                              ),
                            ),
                            SizedBox(height: 50.0),
                            Container(
                                height: 45.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.greenAccent,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: Material(
                                    child: InkWell(
                                      onTap: () async{
                                        var connectivityResult = await (Connectivity().checkConnectivity());
                                        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                          // I am connected to a mobile network.
                                          setState(() {
                                            _nameController.text.isEmpty ? nameValidation = true : nameValidation = false;
                                            _emailController.text.isEmpty ? emailValidation = true : emailValidation = false;
                                            _mobileNumberController.text.isEmpty ? mobileValidation = true : mobileValidation = false;
                                            _countryNameController.text.isEmpty ? countryNameValidation = true : countryNameValidation = false;
                                            loading = true;
                                          });
                                        }
                                        else
                                        {
                                          showInSnackBar("No internet available.Please check your internet connection");
                                        }
                                          pr.show();
                                          var url =
                                              API_URL+'register';

                                          Map<String, dynamic> data = {
                                            'fullname': _nameController.text,
                                            'emailid': _emailController.text,
                                            'country': '101',
                                            'mobilenumber': _mobileNumberController.text,
                                            'termscondition': 'TRUE',
                                            'source_id' : '0'
                                          };

                                          print('url'+url);
                                          print(data);

                                            final response = await http.post(url,
                                                headers: {
                                                  "Accept": "application/json",
                                                  "Content-Type": "application/x-www-form-urlencoded"
                                                },
                                                encoding: Encoding.getByName("utf-8"),
                                                body: data).timeout(Duration(seconds: 15));
                                            SharedPreferences prefs =
                                            await SharedPreferences.getInstance();

                                            final int statusCode = response.statusCode;

                                            print(statusCode);

                                            if(statusCode == 200)
                                            {
                                              pr.hide();
                                              loading = false;
                                              var convertDataToJson = json.decode(response.body);
                                              var status = convertDataToJson['status'];
                                              var statusMessage = convertDataToJson['message'];
                                              var customer_id = convertDataToJson['customer_id'];
                                              prefs.setString('customerID', customer_id);
                                              prefs.setString('customerEmail', _emailController.text);
                                              if(status == true)
                                              {
                                                showInSnackBar(statusMessage);
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext ctx) =>
                                                            ActivationCode()));
                                              }
                                              else if(status == false && statusMessage == 'Your email id is not verified. please verify your email.')
                                              {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.warning,
                                                  title: statusMessage,
                                                  //desc: statusMessage,
                                                  buttons: [
                                                    DialogButton(
                                                      child: Text(
                                                        "Resend Activation Code",
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      ),
                                                      onPressed: () async{
                                                       // new Future.delayed(const Duration(seconds: 1), () async{
                                                          // When task is over, close the dialog
                                                          SharedPreferences prefs =
                                                          await SharedPreferences.getInstance();
                                                          var customerID = prefs.getString('customerID');
                                                          var url =
                                                              'https://ichapps.com/RestApi/resend-verify-code';

                                                          Map<String, dynamic> data = {
                                                            'customer_id': customerID
                                                          };
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext ctx) =>
                                                                      ActivationCode()));

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
                                                              var convertDataToJson = json.decode(response.body);
                                                              var status = convertDataToJson['status'];
                                                              var statusMessage = convertDataToJson['message'];
                                                              if(status == true)
                                                                {
                                                                  showInSnackBar(statusMessage);
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (BuildContext ctx) =>
                                                                              ActivationCode()));
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
                                                            throw new Exception(
                                                                "Error while fetching data");
                                                          }
                                                          else
                                                          {
                                                            print(statusCode);
                                                            pr.hide();
                                                            loading = false;
                                                            var convertDataToJson = json.decode(response.body);
                                                            var statusMessage = convertDataToJson['message'];
                                                            showInSnackBar(statusMessage);
                                                          }
                                                         // Navigator.of(context, rootNavigator: true).pop('dialog');
                                                         // Navigator.of(context, rootNavigator: true).pop();

                                                      //  }
                                                        //);
                                                      },
                                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                                    ),
                                                  ],
                                                ).show();
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
                                              //showInSnackBar("Error while fetching data");
                                              throw new Exception(
                                                  "Error while fetching data");
                                            }
                                            else
                                            {
                                              print(statusCode);
                                              pr.hide();
                                              loading = false;
                                              var convertDataToJson = json.decode(response.body);
                                              var statusMessage = convertDataToJson['message'];
                                              showInSnackBar(statusMessage);
                                             // showInSnackBar("something went wrong, please try again");
                                            }
                                        setState(() {
                                          loading = false;
                                        });
                                            return response;
                                      },
                                      child: Text(
                                        'Join Now',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: 45.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child:

                                  Center(
                                    child: Text('Go Back',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat')),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ]
              ),
            ],
          ),
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