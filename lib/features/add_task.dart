import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/reusable_widget/custom_text_formfield.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskNamecontroller = TextEditingController();

  final TextEditingController descriptionTaskcontroller =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHigher = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormfield(
                        controller: taskNamecontroller,
                        titel: 'task name',
                        hintText: 'Finish UI design for login screen',
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please enter task name";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20.0),
                      CustomTextFormfield(
                        controller: descriptionTaskcontroller,
                        titel: 'description',
                        hintText:
                            'Finish onboarding UI and hand off to devs by Thursday',
                        maxLines: 5,
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'high piority',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Switch(
                            value: isHigher,
                            onChanged: (bool value) {
                              setState(() {
                                isHigher = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),

                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    final taskjson = PreferencesManeger().getString("tasks");
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

                    await PreferencesManeger().setString("tasks", taskEncode);

                    Navigator.of(context).pop(true);
                  }
                },
                label: Text(
                  'Add task',
                  // style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
