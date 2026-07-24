import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class TodoTasksScreen extends StatelessWidget {
  const TodoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (context) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();

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
                child: controller.isloading
                    ? Center(child: CircularProgressIndicator())
                    : Consumer<TasksController>(
                        builder: (context, value, child) {
                          return TaskListWidget(
                            emptyState: 'No tasks To do',
                            tasks: value.todoTasks,
                            onTap: (value, index) async {
                              controller.doneTasks(value, index);
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
            ),
          ],
        );
      },
    );
  }
}
