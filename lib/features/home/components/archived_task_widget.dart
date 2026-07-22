import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/home/home_controller.dart';

class ArchivedTaskWidget extends StatelessWidget {
  const ArchivedTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ThemeController.isDark()
                  ? Colors.transparent
                  : Color(0xffD1DAD6),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Achieved Tasks",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "${controller.totalDoneTasks} Out of ${controller.totalTasks} Done",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: -pi / 2,
                        child: CircularProgressIndicator(
                          value: controller.percent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff15B86C),
                          ),
                          backgroundColor: Color(0xff6D6D6D),
                        ),
                      ),
                      Text(
                        "${(controller.percent * 100).toInt()}%",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
