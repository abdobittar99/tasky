import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final TextEditingController taskNamecontroller = TextEditingController();

  final TextEditingController descriptionTaskcontroller =
      TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  bool isHigher = true;

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final taskjson = PreferencesManeger().getString(StorageKey.tasks);
      List<dynamic> listTasks = [];
      if (taskjson != null) {
        listTasks = jsonDecode(taskjson);
      }
      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNamecontroller.text,
        taskDescription: descriptionTaskcontroller.text,
        ishighPriority: isHigher,
      );

      listTasks.add(model.toMap());

      final taskEncode = jsonEncode(listTasks);

      await PreferencesManeger().setString(StorageKey.tasks, taskEncode);

      Navigator.of(context).pop(true);
    }
    notifyListeners();
  }

  void toggle(bool value) {
    isHigher = value;
    notifyListeners();
  }
}
