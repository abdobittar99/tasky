import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_item_actions_enum.dart';
import 'package:tasky/core/reusable_widget/custom_checkbox.dart';
import 'package:tasky/core/reusable_widget/custom_text_formfield.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int?) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8.0),
            child: CustomCheckbox(value: model.isDone, onChanged: onChanged),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,

                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0xffA0A0A0) : Color(0xffC6C6C6))
                  : (model.isDone ? Color(0xff6A6A6A) : Color(0xff3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                case TaskItemActionsEnum.edit:
                  final result = await _showBottomSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionsEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future _showAlertDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Task", style: TextStyle(fontSize: 20)),
          content: Text("Are u sure u want to delete this task"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);

                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text("Delete", style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showBottomSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNamecontroller = TextEditingController(
      text: model.taskName,
    );
    TextEditingController descriptionTaskcontroller = TextEditingController(
      text: model.taskDescription,
    );
    GlobalKey<FormState> key = GlobalKey<FormState>();
    bool isHigher = model.ishighPriority;

    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,

      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0),
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

                          SizedBox(height: 10.0),
                          CustomTextFormfield(
                            controller: descriptionTaskcontroller,
                            titel: 'description',
                            hintText:
                                'Finish onboarding UI and hand off to devs by Thursday',
                            maxLines: 5,
                          ),
                          SizedBox(height: 10.0),
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
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),

                      onPressed: () async {
                        if (key.currentState?.validate() ?? false) {
                          final taskjson = PreferencesManeger().getString(
                            "tasks",
                          );
                          List<dynamic> listTasks = [];
                          if (taskjson != null) {
                            listTasks = jsonDecode(taskjson);
                          }
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNamecontroller.text,
                            taskDescription: descriptionTaskcontroller.text,
                            ishighPriority: isHigher,
                            isDone: model.isDone,
                          );

                          final item = listTasks.firstWhere(
                            (e) => e['id'] == model.id,
                          );
                          final int index = listTasks.indexOf(item);
                          listTasks[index] = newModel.toMap();

                          final taskEncode = jsonEncode(listTasks);

                          await PreferencesManeger().setString(
                            "tasks",
                            taskEncode,
                          );

                          Navigator.of(context).pop(true);
                        }
                      },
                      label: Text(
                        'Edit task',
                        // style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
