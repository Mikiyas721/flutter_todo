import 'package:flutter/material.dart';

class DateCardBlurred extends StatelessWidget {
  final String dayOfWeek;
  final int dayOfMonth;

  DateCardBlurred({@required this.dayOfWeek, @required this.dayOfMonth});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width:60,
          height: 90,
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xfff6f6f6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(dayOfMonth.toString(),
                  style: TextStyle(
                      color: Color(0xff6e6e6e),
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              Text(
                dayOfWeek,
                style: TextStyle(color: Color(0xff6e6e6e), fontSize: 12),
              )
            ],
          ),
        )
      ],
    );
  }
}

class DateCardHighlighted extends StatelessWidget {
  final String dayOfWeek;
  final int dayOfMonth;

  DateCardHighlighted({@required this.dayOfWeek, @required this.dayOfMonth});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width:60,
        height: 90,
        margin: EdgeInsets.only(bottom: 12, top: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xff006bff)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dayOfMonth.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Text(
              dayOfWeek,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
      CircleAvatar(
        radius: 3,
        backgroundColor: Color(0xff006bff),
      )
    ]);
  }
}
