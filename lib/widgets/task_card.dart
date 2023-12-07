import 'package:flutter/material.dart';
import 'package:google_todo_app/models/task_model.dart';
import 'package:google_todo_app/widgets/update_status_dialog.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return UpdateStatusDialog(task: widget.task);
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.task.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.task.status,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: widget.task.status
                                  .toLowerCase()
                                  .contains("canceled")
                              ? Colors.red
                              : widget.task.status
                                      .toLowerCase()
                                      .contains("progress")
                                  ? Colors.blue
                                  : widget.task.status
                                          .toLowerCase()
                                          .contains("not")
                                      ? Colors.orange
                                      : Colors.green),
                    ),
                  ],
                ),
                Text(widget.task.team.name)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
