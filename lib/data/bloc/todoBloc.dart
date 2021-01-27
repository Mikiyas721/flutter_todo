import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/apiQuery.dart';
import '../../util/preferenceKeys.dart';
import '../../util/abstracts/disposable.dart';

class TodoBloc extends Disposable {
  final _currentDate = GetIt.instance.get<BehaviorSubject<DateTime>>();
  final _currentDateTasks = GetIt.instance.get<BehaviorSubject<List>>();
  final _api = GetIt.instance.get<ApiQuery>();
  final preference = GetIt.instance.get<SharedPreferences>();

  Stream<List> get currentDateTasksStream =>
      _currentDateTasks.map((value) => value);

  DateTime get currentDate => _currentDate.value;

  void updateCurrentDate(DateTime date) {
    _currentDate.add(date);
    getCurrentDayTasks();
  }

  void getCurrentDayTasks() async {
    QueryResult result = await _api.getTodoForUser(preference.getInt(PreferenceKeys.userIdKey),
        _currentDate.value.toString().split(' ')[0]);
    if(!result.hasException){
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

  @override
  void dispose() {
    _currentDate.close();
    _currentDateTasks.close();
  }
}
