import 'package:flutter/material.dart';
import '../widgets/myIcon.dart';

class TodoTextField extends StatelessWidget {
  final String initialText;
  final void Function() onTap;
  final bool isDate;

  TodoTextField({@required this.initialText, @required this.onTap,this.isDate = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: initialText),
      onTap: onTap,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 25),
          prefixIcon: MyIcon(
              backgroundColor: Color(0x55006bff),
              color: Color(0xff006bff),
              icon: isDate?Icons.calendar_today:Icons.access_time),
          suffixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.edit,
              color: Color(0xffe3e3e3),
            ),
          )),
    );
  }
}
