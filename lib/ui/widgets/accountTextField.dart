import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final void Function(String enteredValue) onChanged;
  final void Function() onTap;
  final bool obscureText;
  final TextInputType keyboardType;
  final String errorText;

  MyTextField({@required this.hintText,
    @required this.prefixIcon,
    @required this.onChanged,
    this.onTap, this.obscureText = false,
    this.keyboardType = TextInputType.text, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
            errorText:errorText,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0x99006bff),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: Color(0xcc006bff),
            )),
        style: TextStyle(fontSize: 20),
        onChanged: onChanged,
        onTap: onTap,
      ),
    ]);
  }
}
