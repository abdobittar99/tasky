import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> completeTask = [];
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
        completeTask = taskDecode
            .where((e) => e != null)
            .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
            .where((e) => e.isDone)
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
        completeTask.removeWhere((task) => task.id == id);
      });

      final updatedtasks = tasks.map((e) => e.toMap()).toList();
      PreferencesManeger().setString("tasks", jsonEncode(updatedtasks));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Complete Task',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: TaskListWidget(
              emptyState: 'No tasks To do',
              tasks: completeTask,
              onTap: (value, index) async {
                setState(() {
                  completeTask[index!].isDone = value ?? false;
                });
                final allData = PreferencesManeger().getString("tasks");
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
                      .toList();
                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == completeTask[index!].id,
                  );
                  allDataList[newIndex] = completeTask[index!];
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
        ),
      ],
    );
  }
}
