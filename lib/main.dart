import 'package:flutter/material.dart';
import 'package:todo/ui/pages/homePage.dart';
import './ui/pages/taskManipulationPage.dart';
import './ui/pages/openingPage.dart';
import './ui/pages/loginPage.dart';
import './ui/pages/signUpPage.dart';
import 'injector.dart';

void main() {
  inject();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      initialRoute: '/',
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => OpeningPage(),
  '/loginPage':(BuildContext context) => LoginPage(),
  '/signUpPage':(BuildContext context) => SignUpPage(),
  '/homePage':(BuildContext context) => HomePage(),
  '/taskManipulationPage':(BuildContext context) => TaskManipulationPage()
};
