class TodoTask {
  int? id;
  String? taskName;
  String? taskTime;
  bool isDonne;

  TodoTask({
    this.id,
    required this.isDonne,
    required this.taskName,
    required this.taskTime,
  });

  factory TodoTask.fromMap(Map<String, dynamic> json) => TodoTask(
        id: json["id"],
        taskName: json["taskName"],
        taskTime: json["taskTime"],
        isDonne: json["isDone"] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        "taskName": taskName,
        "taskTime": taskTime,
        "isDone": isDonne ? 1 : 0,
      };
}
