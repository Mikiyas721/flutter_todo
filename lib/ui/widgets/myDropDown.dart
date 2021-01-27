import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  final List<String> items;
  final String currentItem;
  final String title;
  final void Function(String selectedValue) onChanged;

  MyDropDown(
      {@required this.items,
        @required this.title,
        @required this.onChanged,
        this.currentItem});

  @override
  State<StatefulWidget> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String selectedValue;

  @override
  void initState() {
    selectedValue = widget.currentItem ?? widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 18),
        ),
        DropdownButton<String>(
            value: selectedValue,
            items: widget.items
                .map<DropdownMenuItem<String>>((String value) =>
                DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(color: Colors.black45))))
                .toList(),
            onChanged: (String value) {
              setState(() {
                selectedValue = value;
                widget.onChanged(value);
              });
            })
      ],
    );
  }
}
