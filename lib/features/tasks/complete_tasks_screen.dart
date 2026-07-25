import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

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
            child: Consumer<TasksController>(
              builder: (context, valueController, child) {
                return TaskListWidget(
                  emptyState: 'No tasks To do',
                  tasks: valueController.completeTasks,
                  onTap: (value, index) async {
                    controller.doneTasks(
                      value,
                      valueController.completeTasks[index!].id,
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
