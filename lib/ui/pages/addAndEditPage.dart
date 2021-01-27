import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/bloc/todoBloc.dart';
import '../widgets/todoTextField.dart';
import '../widgets/myDropDown.dart';
import '../../util/mixin/dateTimeMixin.dart';
import '../../util/enums/priority.dart';

class AddAndEditPage extends StatelessWidget with DateTimeMixin {
  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
        blocSource: () => TodoBloc(),
        builder: (BuildContext context, TodoBloc bloc) {
          bloc.loadPassedData(map);
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
                            builder: (context, snapshot) {
                              return TodoTextField(
                                  isDate: true,
                                  initialText: getFullDateString(snapshot.data),
                                  onTap: () async {
                                    DateTime selected = await showDatePicker(
                                        context: context,
                                        initialDate: snapshot.data,
                                        firstDate: DateTime(1998),
                                        lastDate: DateTime(2100));
                                    if(selected!=null) bloc.updateDate(selected);
                                  });
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: StreamBuilder(
                              stream: bloc.startTimeStream,
                              builder: (context, snapshot) {
                                return TodoTextField(
                                  initialText: mapTimeToMeridian(snapshot.data),
                                  onTap: () async {
                                    TimeOfDay selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                snapshot.data));
                                    if(selectedTime!=null) bloc.updateStartTime(selectedTime);
                                  },
                                );
                              }),
                          width: 180,
                        ),
                        SizedBox(
                          child: StreamBuilder(
                              stream: bloc.endTimeStream,
                              builder: (context, snapshot) {
                                return TodoTextField(
                                  initialText: mapTimeToMeridian(snapshot.data),
                                  onTap: () async {
                                    TimeOfDay selectedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                snapshot.data));
                                    if(selectedTime!=null) bloc.updateEndTime(selectedTime);
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
                        onPressed: () async{
                          bool result = map['todo'] == null
                              ? await bloc.onAddTodo()
                              : await bloc.onUpdateTodo(map['todo'].id);
                          if (result && map['todo'] == null)
                            Toast.show('Successfully added task', context);
                          else if (!result && map['todo'] == null)
                            Toast.show('Unable to added task.Please Try Again',
                                context);
                          else if (result && map['todo'] != null) {
                            Toast.show('Successfully updated task', context);
                            Navigator.pop(context);
                          } else if (!result && map['todo'] != null)
                            Toast.show('Unable to update task.Please Try Again',
                                context);
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
