import 'package:flutter/material.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/bloc/todoBloc.dart';
import '../widgets/todoTextField.dart';
import '../widgets/myDropDown.dart';
import '../../util/mixin/dateTimeMixin.dart';
import '../../util/enums/priority.dart';

class AddAndEditPage extends StatelessWidget with DateTimeMixin {
  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute
        .of(context)
        .settings
        .arguments;
    return BlocProvider(
        blocSource: () => TodoBloc(context),
        onInit: (TodoBloc bloc) {
          return bloc.loadPassedData(map);
        },
        builder: (BuildContext context, TodoBloc bloc) {
          return Scaffold(
            backgroundColor: Color(0xfffbfbfb),
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              backgroundColor: Color(0xfffbfbfb),
              title: Text(
                map['todo'] == null ? 'Add' : 'Edit',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xff006bff)),
              ),
              elevation: 0,
              centerTitle: true,
              toolbarHeight: 100,
              leadingWidth: 80,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller:
                      TextEditingController(text: map['todo']?.title),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(top: 20, bottom: 20, left: 10),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.edit,
                            color: Color(0xffe3e3e3),
                          ),
                        ),
                      ),
                      onChanged: bloc.updateTitle,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: StreamBuilder(
                            stream: bloc.dateStream,
                            builder: (context, AsyncSnapshot<DateTime> snapshot) {
                              return TodoTextField(
                                  isDate: true,
                                  initialText: getFullDateString(snapshot.data),
                                  onTap: () async {
                                    await bloc.onDate(snapshot.data);
                                  });
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: StreamBuilder(
                              stream: bloc.startTimeStream,
                              builder: (context,
                                  AsyncSnapshot<DateTime> snapshot) {
                                return TodoTextField(
                                  initialText: mapTimeToMeridian(snapshot.data),
                                  onTap: () async {
                                    await bloc.onStartTime(snapshot.data);
                                  },
                                );
                              }),
                          width: 180,
                        ),
                        SizedBox(
                          child: StreamBuilder(
                              stream: bloc.endTimeStream,
                              builder: (context,
                                  AsyncSnapshot<DateTime> snapshot) {
                                return TodoTextField(
                                  initialText: mapTimeToMeridian(snapshot.data),
                                  onTap: () async {
                                    await bloc.onEndTime(snapshot.data);
                                  },
                                );
                              }),
                          width: 180,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyDropDown(
                      items: ['High', 'Medium', 'Low'],
                      title: 'Priority',
                      onChanged: bloc.updatePriority,
                      currentItem: map['todo'] == null
                          ? null
                          : ((map['todo'].priority) as TaskPriority)
                          .getString(),
                    )
                  ],
                ),
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
                        onPressed: () async {
                          await bloc.onAddOrSave(map);
                        },
                        color: Color(0xff006bff),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(40))),
                        child: Text(
                          map['todo'] == null ? 'Add' : 'Save',
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
