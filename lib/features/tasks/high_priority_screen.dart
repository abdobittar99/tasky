import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    _loadjson();
  }

  void _loadjson() async {
    setState(() {
      isloading = true;
    });
    final finalTask = PreferencesManeger().getString('tasks');
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        highPriorityTasks = taskDecode
            .where((e) => e != null)
            .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
            .where((e) => e.ishighPriority)
            .toList();

        highPriorityTasks = highPriorityTasks.reversed.toList();
      });
    }
    setState(() {
      isloading = false;
    });
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManeger().getString('tasks');
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskDecode.map((element) => TaskModel.fromJson(element)).toList();
      tasks.removeWhere((e) => e.id == id);
      setState(() {
        highPriorityTasks.removeWhere((task) => task.id == id);
      });

      final updatedtasks = tasks.map((e) => e.toMap()).toList();
      PreferencesManeger().setString("tasks", jsonEncode(updatedtasks));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("high priority tasks")),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: isloading
            ? CircularProgressIndicator()
            : TaskListWidget(
                emptyState: 'No tasks To do',
                tasks: highPriorityTasks,
                onTap: (value, index) async {
                  setState(() {
                    highPriorityTasks[index!].isDone = value ?? false;
                  });
                  final allData = PreferencesManeger().getString("tasks");
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((e) => TaskModel.fromJson(e))
                        .toList();
                    final newIndex = allDataList.indexWhere(
                      (e) => e.id == highPriorityTasks[index!].id,
                    );
                    allDataList[newIndex] = highPriorityTasks[index!];
                    PreferencesManeger().setString(
                      "tasks",
                      jsonEncode(allDataList.map((e) => e.toMap()).toList()),
                    );
                    _loadjson();
                  }
                },
                onDelete: (int? id) {
                  _deleteTask(id);
                },
                onEdit: () {
                  _loadjson();
                },
              ),
      ),
    );
  }
}
