import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/features/add_task/add_task.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/features/home/components/archived_task_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? userImageProf;
  String? motivattionQuote;

  List<TaskModel> tasks = [];
  bool isloading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadjson();
  }

  void _loadUser() async {
    setState(() {
      username = PreferencesManeger().getString(StorageKey.username);
      userImageProf = PreferencesManeger().getString(StorageKey.userImage);
      motivattionQuote =
          PreferencesManeger().getString(StorageKey.motivattionQuote) ??
          "One task at a time.One step closer.";
    });
  }

  void _loadjson() async {
    setState(() {
      isloading = true;
    });
    final finalTask = PreferencesManeger().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskDecode
            .where((e) => e != null)
            .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
            .toList();
        _calculatePercent();
      });
    }
    setState(() {
      isloading = false;
    });
  }

  _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  _donTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });
    final updatedtasks = tasks.map((e) => e.toMap()).toList();
    PreferencesManeger().setString(StorageKey.tasks, jsonEncode(updatedtasks));
  }

  _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calculatePercent();
    });
    final updatedtasks = tasks.map((e) => e.toMap()).toList();
    PreferencesManeger().setString(StorageKey.tasks, jsonEncode(updatedtasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40.0,
                        child: CircleAvatar(
                          radius: 100,

                          backgroundImage: userImageProf == null
                              ? AssetImage('assets/images/abdo.png')
                              : FileImage(File(userImageProf!)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'welcom $username ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "$motivattionQuote",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Yuhuu ,Your work Is ',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done !  ',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),

                      SvgPicture.asset('assets/images/waving-hand.svg'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ArchivedTaskWidget(
                    doneTasks: totalDoneTasks,
                    totalTasks: totalTasks,
                    percent: percent,
                  ),
                  SizedBox(height: 8.0),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (value, index) {
                      _donTask(value, index);
                    },
                    reload: () {
                      _loadjson();
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16.0),
                    child: Text(
                      'My Tasks',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
            isloading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary,
                      ),
                    ),
                  )
                : SliverTaskListWidget(
                    emptyState: 'No Data',
                    tasks: tasks,
                    onTap: (value, index) async {
                      _donTask(value, index);
                    },
                    onDelete: (int? id) {
                      _deleteTask(id);
                    },
                    onEdit: () {
                      _loadjson();
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTask();
                },
              ),
            );
            if (result != null && result) {
              _loadjson();
            }
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
        ),
      ),
    );
  }
}
