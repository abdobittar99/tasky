import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tasky/models/task_model.dart';

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._();

  HiveStorageManager._();

  factory HiveStorageManager() {
    return _instance;
  }

  late Box<TaskModel> _tasksList;

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _tasksList = await Hive.openBox<TaskModel>("tasks");
  }

  saveTasks(List<TaskModel> list) async {
    await _tasksList.clear();

    await _tasksList.addAll(list);
  }

  List<TaskModel> loadTasks() {
    return _tasksList.values.toList();
  }

  clear() {
    _tasksList.clear();
  }
}
