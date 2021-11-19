import 'package:flutter/material.dart';
import 'package:todo/utilits/constant.dart';

class TaskRow extends StatelessWidget {
  final Color color;
  final String taskName;
  final bool isComplete;

  TaskRow({
    required this.color,
    required this.taskName,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isComplete ? Colors.black : color,
      elevation: 5,
      child: ListTile(
        title: Text(
          taskName,
          style: kPrimaryTextStyle.copyWith(
            decoration: isComplete ? TextDecoration.lineThrough : null,
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }
}
