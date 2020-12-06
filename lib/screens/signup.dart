import 'package:flutter/material.dart';
import 'package:ichsampleapp/models/CountryService.dart';
import 'package:http/http.dart' as http;
import 'package:ichsampleapp/models/countries.dart';
import 'dart:convert';
import 'package:ichsampleapp/models/countriesList.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'activationcode.dart';

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

class _SignupPageState extends State<SignupPage> {

  CountriesList _records = new CountriesList();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Countries>> key = new GlobalKey();

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
  Widget build(BuildContext context) {
    return new Scaffold(
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
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  // hintText: 'EMAIL',
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Email',
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
                            SizedBox(height: 15.0),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  searchTextField = AutoCompleteTextField<Countries>(
                                      style: new TextStyle(color: Colors.black, fontSize: 16.0),
                                      decoration: new InputDecoration(
                                          suffixIcon: Container(
                                            width: 85.0,
                                            height: 60.0,
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                          filled: true,
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
                              decoration: InputDecoration(
                                  labelText: 'Mobile Number',
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
                                  child: GestureDetector(

                                    child: Center(
                                      child: Text(
                                        'Join Now',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => new ActivationCode()));
                                    },
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
}