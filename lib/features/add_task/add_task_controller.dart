import 'package:flutter/material.dart';
import 'package:tasky/core/services/file_storage_manager.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final TextEditingController taskNamecontroller = TextEditingController();

  final TextEditingController descriptionTaskcontroller =
      TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  bool isHigher = true;

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      List<dynamic> listTasks = await FileStorageManager().loadTasks();

      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNamecontroller.text,
        taskDescription: descriptionTaskcontroller.text,
        ishighPriority: isHigher,
      );

      listTasks.add(model.toMap());
      await FileStorageManager().saveTasks(listTasks);

      if (!context.mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHigher = value;
    notifyListeners();
  }
}
