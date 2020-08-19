import "package:flutter/material.dart";
import 'package:splashscreen/splashscreen.dart';

import "Screens/LoginScreen.dart";
import 'Screens/Signup.dart';
import "Screens/HomePageSIdebar.dart";
import "Screens/User.dart";
import "Pages/homepage.dart";
void main()
{
  runApp(MyApp()
    );
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title : "Try4",
      home : LoginApp(),
      debugShowCheckedModeBanner : false,
      theme : ThemeData(
        primarySwatch : Colors.blue,
        ),
      routes : {
        '/homepage' : (context) => SideBarLayout(),
        '/login' : (context) =>LoginApp(),
        '/roothome' : (context) => HomePage(),
        '/signup_screen' : (context) => SignUp(),
        },
      );
  }
}

