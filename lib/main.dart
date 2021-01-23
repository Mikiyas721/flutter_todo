import 'package:flutter/material.dart';
import './ui/pages/openingPage.dart';
import './ui/pages/loginPage.dart';
import './ui/pages/signUpPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      initialRoute: '/',
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => OpeningPage(),
  '/loginPage':(BuildContext context) => LoginPage(),
  '/signUpPage':(BuildContext context) => SignUpPage()
};
