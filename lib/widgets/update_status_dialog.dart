import 'package:flutter/material.dart';
import 'package:google_todo_app/models/task_model.dart';
import 'package:google_todo_app/providers/tasks_provider.dart';
import 'package:provider/provider.dart';

class UpdateStatusDialog extends StatefulWidget {
  const UpdateStatusDialog({super.key, required this.task});
  final TaskModel task;
  @override
  State<UpdateStatusDialog> createState() => _UpdateStatusDialogState();
}

class _UpdateStatusDialogState extends State<UpdateStatusDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.task.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false)
                    .updateTaskStatus(widget.task.id.toString(), "Canceled");
                Navigator.pop(context);
              },
              child: Text("Set as Cancelled")),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false)
                    .updateTaskStatus(widget.task.id.toString(), "Not-Started");
                Navigator.pop(context);
              },
              child: Text("Set as Not-Started")),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false)
                    .updateTaskStatus(widget.task.id.toString(), "In-Progress");
                Navigator.pop(context);
              },
              child: Text("Set as In-Progress")),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false)
                    .updateTaskStatus(widget.task.id.toString(), "Completed");
                Navigator.pop(context);
              },
              child: Text("Set as Completed")),
        ],
      ),
    ));
  }
}
