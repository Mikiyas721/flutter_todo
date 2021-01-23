import 'package:flutter/material.dart';

class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff0022c0), Color(0xff006bff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(top: 60, bottom: 40, left: 30, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TODO',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.54,
              ),
              Text(
                'Task tracker',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Keep track of your tasks daily to have an effective lifestyle.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height:20),
              RaisedButton(
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Color(0xff0042c0)),
                  ),
                  padding: EdgeInsets.only(
                      left: 150, right: 150, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginPage');
                  }),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signUpPage');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.only(
                        left: 145, right: 145, top: 15, bottom: 15),
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
