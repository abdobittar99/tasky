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
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

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
      _loadData();

      _calculatePercent();
    }
    isloading = false;
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((e) => !e.isDone).toList();
    completeTasks = tasks.where((e) => e.isDone).toList();
    highPriorityTasks = tasks.where((e) => e.ishighPriority).toList();

    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  void doneTasks(bool? value, int id) async {
    final index = tasks.indexWhere((e) => e.id == id);
    tasks[index].isDone = value ?? false;
    _loadData();
    _calculatePercent();

    final updatedtasks = tasks.map((e) => e.toMap()).toList();
    PreferencesManeger().setString(StorageKey.tasks, jsonEncode(updatedtasks));
    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    _loadData();
    _calculatePercent();
    final updatedtasks = tasks.map((e) => e.toMap()).toList();
    PreferencesManeger().setString(StorageKey.tasks, jsonEncode(updatedtasks));

    notifyListeners();
  }

  _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }
}
