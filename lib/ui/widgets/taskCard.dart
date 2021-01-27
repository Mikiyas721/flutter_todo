import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/bloc/todoBloc.dart';
import '../../util/mixin/dateTimeMixin.dart';
import '../../util/enums/priority.dart';
import '../../data/models/todo.dart';

class TaskCard extends StatefulWidget {
  final Todo todo;

  TaskCard({@required this.todo});

  @override
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> with DateTimeMixin {
  bool localCompletedState;

  @override
  void initState() {
    localCompletedState = widget.todo.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TodoBloc>(context);
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
                  widget.todo.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Spacer(),
                Checkbox(
                    value: localCompletedState,
                    onChanged: (bool state) {
                      setState(() {
                        localCompletedState = !localCompletedState;
                      });
                      bloc.markTodo(Todo(id: widget.todo.id,isCompleted: localCompletedState));
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
                  ' ${mapTimeToMeridian(
                      widget.todo.startTime)} - ${mapTimeToMeridian(
                      widget.todo.endTime)}',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Text(
                  'Priority: ${widget.todo.priority.getString()}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/addAndEditPage',
            arguments: {'todo': widget.todo, 'date': null});
      },
    );
  }
}
