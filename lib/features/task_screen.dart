import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskModel> todoTasks = [];
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
        todoTasks = taskDecode
            .where((e) => e != null)
            .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
            .where((e) => !e.isDone)
            .toList();
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
        todoTasks.removeWhere((task) => task.id == id);
      });

      final updatedtasks = tasks.map((e) => e.toMap()).toList();
      PreferencesManeger().setString("tasks", jsonEncode(updatedtasks));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'To do Task',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: isloading
                ? CircularProgressIndicator()
                : TaskListWidget(
                    emptyState: 'No tasks To do',
                    tasks: todoTasks,
                    onTap: (value, index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });
                      final allData = PreferencesManeger().getString("tasks");
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((e) => TaskModel.fromJson(e))
                                .toList();
                        final newIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );
                        allDataList[newIndex] = todoTasks[index!];
                        PreferencesManeger().setString(
                          "tasks",
                          jsonEncode(
                            allDataList.map((e) => e.toMap()).toList(),
                          ),
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
        ),
      ],
    );
  }
}
