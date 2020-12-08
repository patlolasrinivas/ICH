import 'package:flutter/material.dart';


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

class _SetPasswordState extends State<SetPassword> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    return new
    Scaffold
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
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    // hintText: 'EMAIL',
                                    // hintStyle: ,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white))),
                              ),
                              SizedBox(height: 20.0),
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
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
                                          'Submit',
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
}
