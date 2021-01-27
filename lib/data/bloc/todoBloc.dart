import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/util/mixin/dateTimeMixin.dart';
import '../../util/enums/priority.dart';
import '../../util/apiQuery.dart';
import '../../util/preferenceKeys.dart';
import '../../util/abstracts/disposable.dart';

class TodoBloc extends Disposable with DateTimeMixin {
  final _currentDate = GetIt.instance.get<BehaviorSubject<DateTime>>();
  final _currentDateTasks = GetIt.instance.get<BehaviorSubject<List>>();
  final _api = GetIt.instance.get<ApiQuery>();
  final preference = GetIt.instance.get<SharedPreferences>();

  final _title =
      GetIt.instance.get<BehaviorSubject<String>>(instanceName: 'Title');
  final _date =
      GetIt.instance.get<BehaviorSubject<DateTime>>(instanceName: 'Date');
  final _startTime =
      GetIt.instance.get<BehaviorSubject<DateTime>>(instanceName: 'StartTime');
  final _endTime =
      GetIt.instance.get<BehaviorSubject<DateTime>>(instanceName: 'EndTime');
  final _priority = GetIt.instance
      .get<BehaviorSubject<TaskPriority>>(instanceName: 'Priority');

  Stream<List> get currentDateTasksStream =>
      _currentDateTasks.map((value) => value);

  Stream<String> get titleStream => _title.map((value) => validateTitle(value));

  Stream<DateTime> get dateStream => _date.map((value) => value);

  Stream<DateTime> get startTimeStream => _startTime.map((value) => value);

  Stream<DateTime> get endTimeStream => _endTime.map((value) => value);

  Stream<TaskPriority> get priorityStream => _priority.map((value) => value);

  DateTime get currentDate => _currentDate.value;

  String validateTitle(String newValue) =>
      newValue.length < 4 ? 'Title must at least 4 characters long' : null;

  void updateCurrentDate(DateTime date) {
    _currentDate.add(date);
    _currentDateTasks.add(null);
    getCurrentDayTasks();
  }

  void updateTitle(String title) => _title.add(title);

  void updateDate(DateTime date) => _date.add(date);

  void updateStartTime(TimeOfDay time) =>
      _startTime.add(DateTime(0, 0, 0, time.hour, time.hour));

  void updateEndTime(TimeOfDay time) =>
      _endTime.add(DateTime(0, 0, 0, time.hour, time.hour));

  void updatePriority(String priority) =>
      _priority.add(TaskPriorityExtension.fromString(priority));

  void getCurrentDayTasks() async {
    QueryResult result = await _api.getTodoForUser(
        preference.getInt(PreferenceKeys.userIdKey),
        _currentDate.value.toString().split(' ')[0]);
    if (!result.hasException) {
      _currentDateTasks.add(result.data['todos']);
    }
  }

  List<DateTime> getDates() {
    DateTime start = DateTime.parse(GetIt.instance
        .get<SharedPreferences>()
        .getString(PreferenceKeys.createdAtKey));
    DateTime end = DateTime.now().add(Duration(days: 100));
    final daysToGenerate = end.difference(start).inDays;
    return List.generate(daysToGenerate,
        (i) => DateTime(start.year, start.month, start.day + (i)));
  }

  int getTodayIndex() {
    DateTime start = DateTime.parse(GetIt.instance
        .get<SharedPreferences>()
        .getString(PreferenceKeys.createdAtKey));
    return DateTime.now().day - start.day;
  }

  Future<bool> onAddTodo() async {
    QueryResult result = await _api.addTodo(Todo(
        title: _title.value,
        date: _date.value,
        startTime: _startTime.value,
        endTime: _endTime.value,
        priority: _priority.value,
        userId: preference.getInt(PreferenceKeys.userIdKey)));
    if (!result.hasException) {
      getCurrentDayTasks();
      return true;
    }
    return false;
  }
  void markTodo(Todo todo)async{
    await _api.markAsCompletedTodo(todo);
  }
  Future<bool> onUpdateTodo(int id) async {
    QueryResult result = await _api.updateTodo(Todo(
        id: id,
        title: _title.value,
        date: _date.value,
        startTime: _startTime.value,
        endTime: _endTime.value,
        priority: _priority.value,
        userId: preference.getInt(PreferenceKeys.userIdKey)));
    if (!result.hasException) {
      getCurrentDayTasks();
      return true;
    }
    return false;
  }

  void loadPassedData(Map map) {
    if (map['todo'] == null) {
      _date.add(map['date']);
      _startTime.add(DateTime.now());
      _endTime.add(DateTime.now());
      _priority.add(TaskPriority.HIGH);
    } else {
      _title.add(map['todo'].title);
      _date.add(map['todo'].date);
      _startTime.add(map['todo'].startTime);
      _endTime.add(map['todo'].endTime);
      _priority.add(map['todo'].priority);
    }
  }

  @override
  void dispose() {
    _currentDate.close();
    _currentDateTasks.close();
    _title.close();
    _date.close();
    _startTime.close();
    _endTime.close();
    _priority.close();
  }
}
