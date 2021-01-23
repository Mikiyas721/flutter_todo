import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final IconData icon;
  final EdgeInsetsGeometry margin;

  MyIcon({
    @required this.backgroundColor,
    @required this.color,
    @required this.icon,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(10),
      margin: margin ?? EdgeInsets.all(10),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
