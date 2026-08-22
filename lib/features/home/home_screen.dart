import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_size.dart';
import 'package:tasky/features/add_task/add_task.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/home/components/archived_task_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppSize.w16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: AppSize.w40,
                          height: AppSize.h40,
                          child: Selector<HomeController, String?>(
                            selector: (p0, p1) => p1.userImageProf,
                            builder: (context, userImageProf, child) {
                              return CircleAvatar(
                                radius: AppSize.r100,

                                backgroundImage: userImageProf == null
                                    ? AssetImage('assets/images/abdo.png')
                                    : FileImage(File(userImageProf)),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: AppSize.w8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector: (p0, p1) => p1.username,
                                builder: (context, username, child) {
                                  return Text(
                                    'welcom $username ',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  );
                                },
                              ),
                              Selector<HomeController, String?>(
                                selector: (p0, p1) => p1.motivattionQuote,
                                builder: (context, value, child) {
                                  return Text(
                                    "$value.motivattionQuote",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.h16),
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
                    SizedBox(height: AppSize.h16),
                    ArchivedTaskWidget(),
                    SizedBox(height: AppSize.h8),
                    HighPriorityTasksWidget(),

                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize.h24,
                        bottom: AppSize.h16,
                      ),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontSize: AppSize.sp20),
                      ),
                    ),
                  ],
                ),
              ),
              SliverTaskListWidget(),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: AppSize.h40,
          child: Builder(
            builder: (context) {
              return FloatingActionButton.extended(
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
                    if (!context.mounted) return;
                    context.read<TasksController>().loadjson();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(AppSize.r30),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
