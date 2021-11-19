import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/add.dart';
import 'package:todo/screens/carousal_page.dart';
import 'package:todo/screens/task.dart';
import 'package:todo/utilits/sqlite_db_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const id = '/MyHomePage';
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SQLiteDbProvider.db),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        initialRoute: id,
        routes: {
          id: (context) => const MyHomePage(title: 'TODO App'),
          CarouselPage.id: (context) => const CarouselPage(),
          AddTaskScreen.id: (context) =>
              const AddTaskScreen(TodoScreen.taskList),
          Task.id: (context) => Task(),
        },
      ),
    );
  }
  // const MyHomePage(title: 'TODO App')
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void gotoCarouselPage() {
    Navigator.pushNamed(context, CarouselPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gotoCarouselPage();
      },
      onHorizontalDragStart: (co) {
        gotoCarouselPage();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                    text: 'Welcome to ',
                    style: TextStyle(fontSize: 30, color: Colors.black54),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Clear',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      )
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: const TextSpan(
                  text: 'Tap or swipe ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'to begin.',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
