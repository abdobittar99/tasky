import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/features/tasks/complete_tasks_screen.dart';
import 'package:tasky/features/home/home_screen.dart';
import 'package:tasky/features/profile/profile_screen.dart';
import 'package:tasky/features/tasks/task_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final List<Widget> screens = [
    HomeScreen(),
    TaskScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicthure("assets/images/home.svg", 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicthure("assets/images/task.svg", 1),
            label: 'To do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicthure("assets/images/complete.svg", 2),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicthure("assets/images/profile.svg", 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[_currentIndex]),
    );
  }

  _buildSvgPicthure(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
