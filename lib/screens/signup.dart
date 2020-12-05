import 'package:flutter/material.dart';
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

  //static List<Countries> countries = new List<Countries>();
  CountriesList _countriesList = new CountriesList();
  CountriesList country_records;

  bool loading = true;
  var countryList;

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Countries>> key = new GlobalKey();

  Future<CountriesList> getCountries() async{

    try{

      var url = 'https://ichapps.com/RestApi/App/Commons/country_list';

      final response = await http.get(url);
      if(response.statusCode == 200){

        var body = json.decode(response.body);
        var statusCode = body['status'];

        if(statusCode== true){

          Map<String, dynamic> map = json.decode(response.body);
          countryList = map['data'];

          country_records =
          new CountriesList.fromJson(countryList);

          Countries record;
          setState(() {
            for (record in country_records.records) {
              this._countriesList.records.add(record);
            }
          });

        }

        setState(() {
          loading = false;
        });

      }

      else{
        print("error getting countries");

      }

    }catch(e){
      print("error getting countries");

    }
    return country_records;
  }

  @override
  void initState() {
    // TODO: implement initState
    getCountries();
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

                            /* Container(
                    child: Stack(
                      children: <Widget>[
                        loading
                            ? CircularProgressIndicator()
                            : searchTextField = AutoCompleteTextField<Countries>(
                          key: key,
                          clearOnSubmit: false,
                          suggestions: countryList,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            hintText: "Search Name",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          itemFilter: (item, query) {
                            return item.name
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          },
                          itemSorter: (a, b) {
                            return a.name.compareTo(b.name);
                          },
                          itemSubmitted: (item) {
                            setState(() {
                              searchTextField.textField.controller.text = item.name;
                            });
                          },
                          itemBuilder: (context, item) {
                            // ui for the autocompelete row
                            return row(item);
                          },
                        ),

                      ],
                    ),
                  ),*/

                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Select Country',
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
                    // SizedBox(height: 15.0),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       'New to Spotify?',
                    //       style: TextStyle(
                    //         fontFamily: 'Montserrat',
                    //       ),
                    //     ),
                    //     SizedBox(width: 5.0),
                    //     InkWell(
                    //       child: Text('Register',
                    //           style: TextStyle(
                    //               color: Colors.green,
                    //               fontFamily: 'Montserrat',
                    //               fontWeight: FontWeight.bold,
                    //               decoration: TextDecoration.underline)),
                    //     )
                    //   ],
                    // )
                  ]
              ),
            ],
          ),
        ),
    );
  }
}

Widget row(Countries countries) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        countries.name,
        style: TextStyle(fontSize: 16.0),
      ),
      SizedBox(
        width: 10.0,
      ),
    ],
  );
}