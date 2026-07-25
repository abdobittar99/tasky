import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Scaffold(
      appBar: AppBar(title: Text("high priority tasks")),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: controller.isloading
            ? CircularProgressIndicator()
            : Consumer<TasksController>(
                builder: (context, valueController, child) {
                  return TaskListWidget(
                    emptyState: 'No tasks To do',
                    tasks: valueController.highPriorityTasks,
                    onTap: (value, index) async {
                      controller.doneTasks(
                        value,
                        valueController.highPriorityTasks[index!].id,
                      );
                    },
                    onDelete: (int? id) {
                      controller.deleteTask(id);
                    },
                    onEdit: () {
                      controller.init();
                    },
                  );
                },
              ),
      ),
    );
  }
}
