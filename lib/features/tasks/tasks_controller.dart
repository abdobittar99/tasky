import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isloading = false;
  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> highPriorityTasks = [];

  void init() {
    loadjson();
  }

  void loadjson() async {
    isloading = true;
    final finalTask = PreferencesManeger().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskDecode
          .where((e) => e != null)
          .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList();

      todoTasks = tasks.where((e) => !e.isDone).toList();
      completeTasks = tasks.where((e) => e.isDone).toList();
      highPriorityTasks = tasks.where((e) => e.ishighPriority).toList();

      highPriorityTasks = highPriorityTasks.reversed.toList();
    }
    isloading = false;
    notifyListeners();
  }

  void doneTasks(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];
    await PreferencesManeger().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadjson();

    notifyListeners();
  }

  void doneCompleteTasks(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere((e) => e.id == completeTasks[index].id);
    tasks[newIndex] = completeTasks[index];
    await PreferencesManeger().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadjson();

    notifyListeners();
  }

  void doneHighPriorityTasks(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere(
      (e) => e.id == highPriorityTasks[index].id,
    );
    tasks[newIndex] = highPriorityTasks[index];
    await PreferencesManeger().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadjson();

    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);

    todoTasks.removeWhere((task) => task.id == id);
    completeTasks.removeWhere((task) => task.id == id);

    highPriorityTasks.removeWhere((task) => task.id == id);

    final updatedtasks = tasks.map((e) => e.toMap()).toList();
    PreferencesManeger().setString(StorageKey.tasks, jsonEncode(updatedtasks));

    notifyListeners();
  }
}
