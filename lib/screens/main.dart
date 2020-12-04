

import 'package:flutter/material.dart';
import 'package:ichsampleapp/screens/signup.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup' : (BuildContext context) => new SignupPage()
      },
      home: new MyHomePage(title: 'Sign In'),
    );
  }
}

class MyHomePage extends StatefulWidget {



  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children:<Widget>[
          Container(
            child: Stack(
            children: <Widget> [

            Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: Text('',
                style: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold
              ),
              ),

            ),

              Container(
                padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                child: Text('ICH Apps',
                  style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold
                  ),
                ),

              ),
              Container(
                padding: EdgeInsets.fromLTRB(220.0, 150.0, 0.0, 0.0),
                child: Text('.',
                  style: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold, color:Colors.green
                  ),
                ),

              ),

            ],

            ),
          ),
          Container(
            padding:  EdgeInsets.only(top: 35.0, left: 20.0,right: 20.0),
            child: Column(
              children:<Widget> [
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
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(

                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)
                      )
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 5.0,),
                Container(
                  alignment: Alignment(1.0, 0.5),
                  padding: EdgeInsets.only(top: 15.0,left:20.0),
                  child: InkWell(
                    child: Text('ForgotPassword',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline,
                    ),),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  color: Colors.transparent,
                  height: 50.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: (){},
                      child: Center(
                        child: Text('Login',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                    child: Container(
                        height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget> [
                          Center(
                            child: Text('Register Now',style:
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'
                            )
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap:(){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => new SignupPage()));
                  //print("you clicked registered");
                }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
