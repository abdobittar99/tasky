import 'package:flutter/material.dart';
import 'package:tasky/core/reusable_widget/custom_checkbox.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';
import 'package:tasky/models/task_model.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.reload,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function reload;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "High Priority Tasks",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff15B86C),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        tasks.reversed.where((e) => e.ishighPriority).length > 4
                        ? 4
                        : tasks.reversed.where((e) => e.ishighPriority).length,
                    itemBuilder: (context, index) {
                      final task = tasks.reversed
                          .where((e) => e.ishighPriority)
                          .toList()[index];
                      return Row(
                        children: [
                          CustomCheckbox(
                            value: task.isDone,
                            onChanged: (bool? value) {
                              final index = tasks.indexWhere(
                                (element) => element.id == task.id,
                              );
                              onTap(value, index);
                            },
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              task.taskName,

                              style: task.isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HighPriorityScreen();
                    },
                  ),
                );
                reload();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 40,
                  width: 40.0,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    border: Border.all(
                      color: ThemeController.isDark()
                          ? Color(0xff6E6E6E)
                          : Color(0xffD1DAD6),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.arrow_outward_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
