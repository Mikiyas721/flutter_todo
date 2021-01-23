import 'package:flutter/material.dart';
import '../../util/mixin/dateTimeMixin.dart';
import 'dateCard.dart';

class MyPageView extends StatefulWidget {
  final int itemCount;
  final int initialPage;
  final List<DateTime> dates;

  MyPageView(
      {@required this.itemCount,
      @required this.initialPage,
      @required this.dates});

  @override
  State<StatefulWidget> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> with DateTimeMixin {
  DateTime selectedDateTime;

  @override
  void initState() {
    selectedDateTime = widget.dates[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${mapMonth(selectedDateTime.month)} ${selectedDateTime.day}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        PageView.builder(
          controller: PageController(
              initialPage: widget.initialPage, viewportFraction: 0.22),
          scrollDirection: Axis.horizontal,
          onPageChanged: (int index) {
            setState(() {
              selectedDateTime = widget.dates[index];
            });
          },
          itemCount: widget.itemCount,
          itemBuilder: (BuildContext context, int index) {
            return Transform.scale(
                scale: widget.dates[index] == selectedDateTime ? 1.2 : 1,
                child: widget.dates[index] == selectedDateTime
                    ? DateCardHighlighted(
                        dayOfWeek: getDayOfWeek(widget.dates[index].weekday),
                        dayOfMonth: widget.dates[index].day)
                    : DateCardBlurred(
                        dayOfWeek: getDayOfWeek(widget.dates[index].weekday),
                        dayOfMonth: widget.dates[index].day));
          },
        ),
      ],
    );
  }
}
