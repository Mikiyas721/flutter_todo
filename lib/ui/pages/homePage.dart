import 'package:flutter/material.dart';
import '../../data/models/todo.dart';
import '../../ui/widgets/taskCard.dart';
import '../../util/mixin/dateTimeMixin.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/bloc/todoBloc.dart';
import '../../ui/widgets/myPageView.dart';

class HomePage extends StatelessWidget with DateTimeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocSource: () => TodoBloc(),
        builder: (BuildContext context, TodoBloc bloc) {
          List days = bloc.getDates();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              title: MyPageView(
                itemCount: days.length,
                initialPage: bloc.getTodayIndex(),
                dates: days,
                onPageChanged: bloc.updateCurrentDate,
              ),
              toolbarHeight: 200,
            ),
            body: Padding(
              padding: EdgeInsets.only(right: 25, left: 25, top: 10),
              child: StreamBuilder(
                  stream: bloc.currentDateTasksStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    return snapshot.data == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : snapshot.data.isEmpty
                            ? Center(
                                child: Text(
                                    'No tasks for ${getFullDateString(bloc.currentDate)}'),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TaskCard(
                                      todo: Todo.fromApi(snapshot.data[index]));
                                },
                              );
                  }),
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
                          Navigator.pushNamed(context, '/addAndEditPage',arguments:{'todo':null,'date':bloc.currentDate});
                        },
                        color: Color(0xff006bff),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Text(
                          '+ Add new task',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
