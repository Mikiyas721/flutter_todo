import 'package:flutter/material.dart';
import '../../ui/widgets/myPageView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(right: 25, left: 25, top: 60),
        child: Column(children: [
          MyPageView(itemCount: 10, initialPage: 0, dates: [],),
        ]),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
            padding:
                EdgeInsets.only(top: 18, bottom: 18, left: 120, right: 120),
            elevation: 0,
            onPressed: () {},
            color: Color(0xff006bff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              '+ Add new task',
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
    );
  }
}
