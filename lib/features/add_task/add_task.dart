import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/reusable_widget/custom_text_formfield.dart';
import 'package:tasky/features/add_task/add_task_controller.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: controller.key,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormfield(
                            controller: controller.taskNamecontroller,
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
                            controller: controller.descriptionTaskcontroller,
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
                              Consumer<AddTaskController>(
                                builder: (context, value, child) {
                                  return Switch(
                                    value: value.isHigher,
                                    onChanged: (bool value) {
                                      controller.toggle(value);
                                    },
                                  );
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
                      context.read<AddTaskController>().addTask(context);
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
      },
    );
  }
}
