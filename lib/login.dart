
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'root_page.dart';

import 'service_login.dart';



// ignore: camel_case_types
class login_run extends StatelessWidget {
  // login page parameters:
  // primary swatch color
  static const primarySwatch = Colors.orange;
  // button color
  static const buttonColor = Colors.orange;
  // app name
  static const appName = 'My App';
  // boolean for showing home page if user unverified
  static const homePageUnverified = false;

  final params = {
    'appName': appName,
    'primarySwatch': primarySwatch,
    'buttonColor': buttonColor,
    'homePageUnverified': homePageUnverified,
  };


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Nunes Móveis',
        debugShowCheckedModeBanner: true,
        theme: new ThemeData(
          primarySwatch: params['primarySwatch'],
        ),
        home: new RootPage(params: params, auth: new Auth()));
  }
}