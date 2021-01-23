import 'package:flutter/material.dart';
import '../../ui/widgets/myTextField.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff0022c0), Color(0xff006bff)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(60,40),
                  bottomLeft: Radius.elliptical(60,40))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.31,
              child: Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30,15,30,0),
              child: Column(children: [
                MyTextField(
                    hintText: 'Bob Steven',
                    prefixIcon: Icons.note_outlined,
                    onChanged: (String enteredValue) {}),
                MyTextField(
                  keyboardType: TextInputType.emailAddress,
                    hintText: 'XYZ@gmail.com',
                    prefixIcon: Icons.email,
                    onChanged: (String enteredValue) {}),
                MyTextField(
                    hintText: 'Username',
                    prefixIcon: Icons.note_outlined,
                    onChanged: (String enteredValue) {}),
                MyTextField(
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    onChanged: (String enteredValue) {}),
                MyTextField(
                    hintText: 'Repeat Password',
                    prefixIcon: Icons.lock,
                    onChanged: (String enteredValue) {}),
                Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                      padding: EdgeInsets.only(
                          left: 145, right: 145, top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Color(0xff006bff),
                      onPressed: () {}),
                ),
                Center(
                    child: Text(
                      'or',
                      style: TextStyle(color: Color(0x99006bff)),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/loginPage');
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Color(0xff006bff)),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.only(
                            left: 150, right: 150, top: 15, bottom: 15),
                        side: BorderSide(color: Color(0xff006bff)),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)))),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
