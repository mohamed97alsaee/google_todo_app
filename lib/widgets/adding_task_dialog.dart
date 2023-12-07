import 'package:flutter/material.dart';
import 'package:google_todo_app/providers/tasks_provider.dart';
import 'package:provider/provider.dart';

class AddingTaskDialog extends StatefulWidget {
  const AddingTaskDialog({super.key});

  @override
  State<AddingTaskDialog> createState() => _AddingTaskDialogState();
}

class _AddingTaskDialogState extends State<AddingTaskDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
        child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Adding Task",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Name",
              hintText: "Enter Task Name",
            ),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please the task name";
              }

              return null;
            },
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<TasksProvider>(context, listen: false)
                        .addNewTask({
                      "user_id": "44",
                      "name": nameController.text
                    }).then((added) {
                      if (added.first) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Text("Add the Task")),
            ],
          )
        ],
      ),
    ));
  }
}
