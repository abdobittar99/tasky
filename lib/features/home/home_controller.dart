import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];

  String? username;
  String? userImageProf;
  String? motivattionQuote;

  List<TaskModel> tasks = [];
  bool isloading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  init() {
    loadUser();
    loadjson();
  }

  void loadUser() async {
    username = PreferencesManeger().getString(StorageKey.username);
    userImageProf = PreferencesManeger().getString(StorageKey.userImage);
    motivattionQuote =
        PreferencesManeger().getString(StorageKey.motivattionQuote) ??
        "One task at a time.One step closer.";

    notifyListeners();
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
      calculatePercent();
    }
    isloading = false;
    notifyListeners();
  }

  calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }

  donTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedtasks = tasks.map((e) => e.toMap()).toList();
    PreferencesManeger().setString(StorageKey.tasks, jsonEncode(updatedtasks));
    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((task) => task.id == id);
    calculatePercent();

    final updatedtasks = tasks.map((e) => e.toMap()).toList();
    PreferencesManeger().setString(StorageKey.tasks, jsonEncode(updatedtasks));
    notifyListeners();
  }
}
