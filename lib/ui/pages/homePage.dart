import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/preferenceKeys.dart';
import '../../data/models/todo.dart';
import '../../util/enums/priority.dart';
import '../../ui/widgets/myPageView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime start = DateTime.parse(GetIt.instance
        .get<SharedPreferences>()
        .getString(PreferenceKeys.createdAtKey));
    DateTime end = DateTime.now().add(Duration(days: 100));
    final daysToGenerate = end.difference(start).inDays;
    List<DateTime> days = List.generate(daysToGenerate,
        (i) => DateTime(start.year, start.month, start.day + (i)));

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(right: 25, left: 25, top: 60),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            MyPageView(
              itemCount: days.length,
              initialPage: 0,
              dates: days,
            ),
          ]),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: RaisedButton(
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/addAndEditPage',
                        arguments: Todo(
                            title: 'Talk',
                            date: DateTime.now(),
                            priority: TaskPriority.MEDIUM,
                            endTime: DateTime.now(),
                            startTime: DateTime.now()));
                  },
                  color: Color(0xff006bff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Text(
                    '+ Add new task',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
