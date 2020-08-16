
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


import 'login.dart';



void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        //primarySwatch: Colors.orange,
      ),
      home: SelectPage(title: 'Splash Screen Flutter'),
    );
  }
}

class SelectPage extends StatefulWidget {
  SelectPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(

    children: <Widget>[
      SplashScreen(
        seconds: 5,
        backgroundColor: Colors.white,



        navigateAfterSeconds: login_run(),
        loaderColor: Colors.transparent,
      ),
      Padding(
        padding: EdgeInsets.only(top: 100.0, bottom: 100.0,left: 100,right: 100),
        child:
        Container(


          decoration: BoxDecoration(



            image: DecorationImage(



              image: AssetImage('assets/logo-official_laranja.jpeg'),


              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ],
  );
}