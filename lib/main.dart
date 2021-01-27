import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './util/preferenceKeys.dart';
import './ui/pages/homePage.dart';
import './ui/pages/addAndEditPage.dart';
import './ui/pages/openingPage.dart';
import './ui/pages/loginPage.dart';
import './ui/pages/signUpPage.dart';
import 'injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
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

final bool isLoggedIn = GetIt.instance
    .get<SharedPreferences>()
    .getInt(PreferenceKeys.userIdKey) ==
    null
    ? false
    : true;

final routes = {
  '/': (BuildContext context) => isLoggedIn ? HomePage() : OpeningPage(),
  '/loginPage': (BuildContext context) => LoginPage(),
  '/signUpPage': (BuildContext context) => SignUpPage(),
  '/homePage':(BuildContext context)=>HomePage(),
  '/addAndEditPage': (BuildContext context) => AddAndEditPage()
};
