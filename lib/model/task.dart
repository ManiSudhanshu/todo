class Task {
  final String title;
  final DateTime dateTime;
  bool isDone;

  Task({required this.title, required this.dateTime, this.isDone = false});

  void toggleIsDone() {
    isDone = !isDone;
  }
}
