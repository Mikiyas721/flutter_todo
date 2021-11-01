import 'package:flutter/material.dart';
import 'package:todo/data/bloc/accountBloc.dart';
import '../../data/models/todo.dart';
import '../../ui/widgets/taskCard.dart';
import '../../util/mixin/dateTimeMixin.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/bloc/todoBloc.dart';
import '../../ui/widgets/myPageView.dart';

class HomePage extends StatelessWidget with DateTimeMixin {
  @override
  Widget build(BuildContext context) {
    List days;
    return BlocProvider(
        blocSource: () => TodoBloc(context),
        onInit: (TodoBloc bloc) {
          days = bloc.getDates();
        },
        builder: (BuildContext context, TodoBloc bloc) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              title: Stack(
                children: [
                  MyPageView(
                    itemCount: days.length,
                    initialPage: bloc.getTodayIndex(),
                    dates: days,
                    onPageChanged: bloc.updateCurrentDate,
                  ),
                  BlocProvider(
                    blocSource: () => AccountBloc(context),
                    builder: (BuildContext context, AccountBloc bloc) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: IconButton(
                              icon:
                                  Icon(Icons.logout, color: Color(0xffaa3088)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Log out'),
                                        content: Text(
                                            'Are you sure you want to log out?'),
                                        actions: [
                                          FlatButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                          FlatButton(
                                              child: Text('Ok'),
                                              onPressed: bloc.onOk),
                                        ],
                                      );
                                    });
                              }),
                        ),
                      );
                    },
                  ),
                ],
              ),
              toolbarHeight: 200,
            ),
            body: Padding(
              padding:
                  EdgeInsets.only(right: 25, left: 25, top: 10, bottom: 80),
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
                                    todo: Todo.fromApi(snapshot.data[index]),
                                    onTaskStateChanged: (bool isChecked) {
                                      bloc.onTaskStateChanged(
                                          snapshot.data[index], isChecked);
                                    },
                                    onCardTap: () {
                                      bloc.onCardTap(snapshot.data[index]);
                                    },
                                  );
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
                        onPressed: bloc.onAddNewTask,
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
