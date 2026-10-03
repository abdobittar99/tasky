import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/services/hive_storage_manager.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/navigation/home_layout.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/features/welcome/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PreferencesManeger().init();
  ThemeController().init();
  String? userName = PreferencesManeger().getString("userName");
  // await PreferencesManeger().clear();
  await HiveStorageManager().init();
  runApp(MyApp(userName: userName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userName});
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, themeMode, child) {
        return ChangeNotifierProvider<TasksController>(
          create: (context) => TasksController()..init(),
          child: ScreenUtilInit(
            designSize: Size(375, 809),
            minTextAdapt: true,
            builder: (cxt, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'tasky',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                home: userName == null ? Intro() : HomeLayout(),
              );
            },
          ),
        );
      },
    );
  }
}
