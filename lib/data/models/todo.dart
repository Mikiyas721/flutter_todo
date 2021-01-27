import 'package:flutter/cupertino.dart';
import '../../util/abstracts/mappable.dart';
import '../../util/enums/priority.dart';

class Todo extends Mappable {
  int id;
  String title;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  TaskPriority priority;
  int userId;

  Todo({
    this.id,
    @required this.title,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    @required this.priority,
    this.userId,
  });

  factory Todo.fromApi(Map map) {
    return Todo(
        id: map['id'],
        title: map['title'],
        date: map['date'],
        startTime: map['start_time'],
        endTime: map['end_time'],
        priority: map['priority'],
        userId: map['user_id']);
  }

  @override
  Map toMap() {
    return {
      'id':id,
      'title':title,
      'date':date.toString(),
      'start_time':startTime.toString(),
      'end_time':endTime.toString(),
      'priority':priority.getString(),
      'user_id':userId.toString()
    };
  }
}
