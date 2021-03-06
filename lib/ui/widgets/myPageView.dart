import 'package:flutter/material.dart';
import '../../util/mixin/dateTimeMixin.dart';
import 'dateCard.dart';

class MyPageView extends StatefulWidget {
  final int itemCount;
  final int initialPage;
  final List<DateTime> dates;
  final void Function(DateTime dateTime) onPageChanged;

  MyPageView(
      {@required this.itemCount,
      @required this.initialPage,
      @required this.dates,
        @required this.onPageChanged});

  @override
  State<StatefulWidget> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> with DateTimeMixin {
  DateTime selectedDateTime;

  @override
  void initState() {
    selectedDateTime = widget.dates[widget.initialPage];
    widget.onPageChanged(selectedDateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top:30),
          child: Text(
            '${mapMonth(selectedDateTime.month)} ${selectedDateTime.day}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Color(0xff006bff)),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: PageView.builder(
            controller: PageController(
                initialPage: widget.initialPage, viewportFraction: 0.22),
            scrollDirection: Axis.horizontal,
            onPageChanged: (int index) {
              setState(() {
                selectedDateTime = widget.dates[index];
              });
              widget.onPageChanged(selectedDateTime);
            },
            itemCount: widget.itemCount,
            itemBuilder: (BuildContext context, int index) {
              return Transform.scale(
                  scale: widget.dates[index] == selectedDateTime ? 1.1 : 1,
                  child: widget.dates[index] == selectedDateTime
                      ? DateCardHighlighted(
                          dayOfWeek: getDayOfWeekShort(widget.dates[index].weekday),
                          dayOfMonth: widget.dates[index].day)
                      : DateCardBlurred(
                          dayOfWeek: getDayOfWeekShort(widget.dates[index].weekday),
                          dayOfMonth: widget.dates[index].day));
            },
          ),
        ),
      ],
    );
  }
}
