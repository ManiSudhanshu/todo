import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screens/add.dart';
import 'package:todo/utilits/colors.dart';
import 'package:todo/utilits/sqlite_db_provider.dart';
import 'package:todo/widgets/rask_row.dart';

class Task extends StatefulWidget {
  static const id = 'Task';
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Future<List<TodoTask>> getTasks() async {
    List<TodoTask> tasks = await SQLiteDbProvider.db.getAllPersons();
    print(tasks);
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    void dismissItem(SQLiteDbProvider collectionProvider, TodoTask coll,
        DismissDirection direction) {
      switch (direction) {
        case DismissDirection.endToStart:
          collectionProvider.deletePersonWithId(coll);
          break;

        default:
          break;
      }
    }

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<TodoTask>>(
          future: SQLiteDbProvider.db.getAllPersons(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoTask>> snapshot) {
            print(snapshot);
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Consumer<SQLiteDbProvider>(
                        builder: (context, taskProvider, child) {
                      return ReorderableListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: taskProvider.taskCount,
                        itemBuilder: (BuildContext context, int index) {
                          TodoTask item = taskProvider.tasks[index];
                          return Dismissible(
                            onDismissed: (direction) =>
                                dismissItem(taskProvider, item, direction),
                            key: ObjectKey(item),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                              color: Colors.black,
                            ),
                            // secondaryBackground: swipeLeft(),
                            child: TaskRow(
                              taskName: item.taskName ?? 'na',
                              color: index <= 15
                                  ? kStyleColorPalette[index]!
                                  : kStyleColorPalette[15]!,
                              isComplete: item.isDonne,
                            ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          print('old $oldIndex new $newIndex ');
                          taskProvider.reOrderTask(oldIndex, newIndex);
                        },
                      );
                    }),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddTaskScreen.id);
                    },
                    child: Icon(Icons.add),
                  )
                ],
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    const Expanded(
                      child: Center(child: Text('No Task Found')),
                    ),
                    Expanded(
                      child: Center(
                        child: FlatButton(
                            color: Colors.black12,
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, AddTaskScreen.id);
                              });
                            },
                            child: Text('Add')),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
