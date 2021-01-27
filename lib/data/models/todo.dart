import 'package:flutter/cupertino.dart';
import '../../util/abstracts/mappable.dart';
import '../../util/enums/priority.dart';

class Todo extends Mappable{
  int id;
  String title;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  TaskPriority priority;
  bool isCompleted;
  int userId;


  Todo({
    this.id,
    @required this.title,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    @required this.priority,
    @required this.isCompleted,
    this.userId,
  });

  factory Todo.fromApi(Map map) {
    return Todo(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['date']),
        startTime: DateTime.parse("${map['date']} ${map['start_time']}"),
        endTime: DateTime.parse("${map['date']} ${map['end_time']}"),
        priority: TaskPriorityExtension.fromString(map['priority']),
        isCompleted: map['is_completed'],
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
      'is_completed': isCompleted,
      'user_id':userId.toString()
    };
  }
}
