import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/add_task/add_task.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/home/components/archived_task_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40.0,
                          child: Selector<HomeController, String?>(
                            selector: (p0, p1) => p1.userImageProf,
                            builder: (context, userImageProf, child) {
                              return CircleAvatar(
                                radius: 100,

                                backgroundImage: userImageProf == null
                                    ? AssetImage('assets/images/abdo.png')
                                    : FileImage(File(userImageProf)),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 8),
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
                    SizedBox(height: 16),
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
                    SizedBox(height: 16.0),
                    ArchivedTaskWidget(),
                    SizedBox(height: 8.0),
                    HighPriorityTasksWidget(),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16.0),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontSize: 20.0),
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
          height: 40,
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
                    context.read<HomeController>().loadjson();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(30),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
