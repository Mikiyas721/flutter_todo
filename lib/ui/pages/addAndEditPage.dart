import 'package:flutter/material.dart';
import '../../ui/widgets/myDropDown.dart';
import '../../data/models/todo.dart';
import '../../util/mixin/dateTimeMixin.dart';
import '../../ui/widgets/myIcon.dart';
import '../../util/enums/priority.dart';

class AddAndEditPage extends StatelessWidget with DateTimeMixin {
  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    Todo toBeEdited = map['todo'];
    DateTime selectedDate = map['date'];
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
          toBeEdited == null ? 'Add' : 'Edit',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xff006bff)),
        ),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 100,
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: TextEditingController(text: toBeEdited?.title),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.edit,
                      color: Color(0xffe3e3e3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: toBeEdited == null
                          ? getFullDateString(selectedDate)
                          : getFullDateString(toBeEdited.date)),
                  onTap: () async {
                    DateTime selected = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(1998),
                        lastDate: DateTime(2100));
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 25),
                      prefixIcon: MyIcon(
                          backgroundColor: Color(0xffffebe9),
                          color: Color(0xffcc7662),
                          icon: Icons.calendar_today),
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.edit,
                          color: Color(0xffe3e3e3),
                        ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: TextField(
                      controller: TextEditingController(
                          text: toBeEdited == null
                              ? ''
                              : mapTimeToMeridian(toBeEdited.startTime)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 25),
                        prefixIcon: MyIcon(
                            backgroundColor: Color(0xfffdf3e1),
                            color: Color(0xffeac25b),
                            icon: Icons.access_time),
                      ),
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay selectedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        print(selectedTime);
                      },
                    ),
                    width: 150,
                  ),
                  Text(
                    '-',
                    style: TextStyle(fontSize: 35),
                  ),
                  SizedBox(
                    child: TextField(
                      controller: TextEditingController(
                          text: toBeEdited == null
                              ? ''
                              : mapTimeToMeridian(toBeEdited.endTime)),
                      decoration: InputDecoration(
                          prefixIcon: MyIcon(
                              backgroundColor: Color(0xfffdf3e1),
                              color: Color(0xffeac25b),
                              icon: Icons.access_time),
                          contentPadding: EdgeInsets.only(top: 25)),
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay selectedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        print(selectedTime);
                      },
                    ),
                    width: 150,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MyDropDown(
                items: ['High', 'Medium', 'Low'],
                title: 'Priority',
                onChanged: (String selectedValue) {},
                currentItem:
                    toBeEdited == null ? null : toBeEdited.priority.getString(),
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
                    onPressed: () {},
                    color: Color(0xff006bff),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Text(
                      toBeEdited == null ? 'Add' : 'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
