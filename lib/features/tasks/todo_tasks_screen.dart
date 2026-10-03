import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_size.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class TodoTasksScreen extends StatelessWidget {
  const TodoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppSize.w18),
          child: Text(
            'To do Task',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSize.w14),
            child: controller.isloading
                ? Center(child: CircularProgressIndicator())
                : Consumer<TasksController>(
                    builder: (context, valueController, child) {
                      return TaskListWidget(
                        emptyState: 'No tasks To do',
                        tasks: valueController.todoTasks,
                        onTap: (value, index) async {
                          controller.doneTasks(
                            value,
                            valueController.todoTasks[index!].id,
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
        ),
      ],
    );
  }
}
