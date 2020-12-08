import 'package:flutter/material.dart';
import 'package:ichsampleapp/screens/setpassword.dart';

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

  @override
  Widget build(BuildContext context) {
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
                                      onTap: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => new SetPassword()));
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
