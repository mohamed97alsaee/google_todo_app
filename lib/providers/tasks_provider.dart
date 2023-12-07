import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_todo_app/models/task_model.dart';
import 'package:google_todo_app/services/api.dart';

class TasksProvider with ChangeNotifier {
  Api api = Api();
  bool isLoading = true;
  bool isFailed = false;
  List<TaskModel> tasks = [];

  setLoading(bool value) {
    Timer(Duration(milliseconds: 60), () {
      isLoading = value;
      notifyListeners();
    });
  }

  setFailed(bool value) {
    Timer(Duration(milliseconds: 60), () {
      isFailed = value;
      notifyListeners();
    });
  }

  getTasks() {
    setLoading(true);
    api.get('/user/tasks', {}).then((response) {
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body)['data'];

        tasks = decodedData.map<TaskModel>((task) {
          return TaskModel.fromJson(task);
        }).toList();

        setLoading(false);
      } else {
        setFailed(true);
        setLoading(false);
      }
    });
  }

  Future<bool?> updateTaskStatus(String taskId, String status) async {
    await api.put("/user/tasks/$taskId", {"status": status}).then((response) {
      if (response.statusCode == 200) {
        getTasks();
        return true;
      } else {
        return false;
      }
    });
    return null;
  }
}
