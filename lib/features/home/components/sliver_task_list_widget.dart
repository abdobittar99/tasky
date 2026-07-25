import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context, controller, child) {
        final tasks = controller.tasks;
        return controller.isloading
            ? SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            : tasks.isEmpty
            ? SliverToBoxAdapter(
                child: Text(
                  'No Data',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )
            : SliverPadding(
                padding: EdgeInsets.only(bottom: 60),
                sliver: SliverList.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.0);
                  },
                  itemBuilder: (context, index) {
                    return TaskItemWidget(
                      model: tasks[index],
                      onChanged: (bool? value) {
                        controller.doneTasks(value, tasks[index].id);
                      },
                      onDelete: (int? id) {
                        controller.deleteTask(id);
                      },
                      onEdit: () {
                        controller.loadjson();
                      },
                    );
                  },
                ),
              );
      },
    );
  }
}
