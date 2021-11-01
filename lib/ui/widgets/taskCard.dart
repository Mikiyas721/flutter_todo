import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/bloc/todoBloc.dart';
import '../../util/mixin/dateTimeMixin.dart';
import '../../util/enums/priority.dart';
import '../../data/models/todo.dart';

class TaskCard extends StatelessWidget with DateTimeMixin {
  final Todo todo;
  final Function(bool isCheck) onTaskStateChanged;
  final VoidCallback onCardTap;

  TaskCard({
    @required this.todo,
    @required this.onTaskStateChanged,
    @required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xff006bff)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Spacer(),
                Checkbox(
                    value: todo.isCompleted,
                    onChanged: (bool state) async {
                      onTaskStateChanged(state);
                    })
              ],
            ),
            Divider(
              color: Colors.white38,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white54,
                ),
                Text(
                  ' ${mapTimeToMeridian(todo.startTime)} - ${mapTimeToMeridian(todo.endTime)}',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Text(
                  'Priority: ${todo.priority.getString()}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: onCardTap,
    );
  }
}
