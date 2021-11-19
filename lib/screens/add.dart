import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/utilits/colors.dart';
import 'package:todo/utilits/constant.dart';
import 'package:todo/utilits/sqlite_db_provider.dart';

enum TodoScreen { collection, taskList }

class AddTaskScreen extends StatelessWidget {
  final TodoScreen whichScreen;
  static const id = 'add';

  const AddTaskScreen(this.whichScreen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: kStyleColorPalette[0],
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: kPrimaryTextStyle.copyWith(),
                  decoration: const InputDecoration(
                    // filled: true,
                    border: InputBorder.none,
                  ),
                  autofocus: true,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  onSubmitted: (finalValue) {
                    showDatePicker(context, finalValue, whichScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDatePicker(
    BuildContext context,
    String title,
    TodoScreen whichScreen,
  ) {
    return DatePicker.showDatePicker(context,
        theme: DatePickerTheme(headerColor: Colors.black12),
        showTitleActions: true,
        minTime: DateTime(2020, 3, 1),
        maxTime: DateTime(2029, 6, 7), onConfirm: (date) {
      if (whichScreen == TodoScreen.collection) {
        // final p = Provider.of<CollectionProvider>(context, listen: false);
        // p.addCollection(title, date);
      } else if (whichScreen == TodoScreen.taskList) {
        final p = Provider.of<SQLiteDbProvider>(context, listen: false);
        p.addTaskToDatabase(TodoTask(
            taskName: title, taskTime: date.toString(), isDonne: false));
      }
      Navigator.pop(context);
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  saveToCollection() {}
}
