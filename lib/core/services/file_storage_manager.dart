import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager() {
    return _instance;
  }

  late final Directory _appDocumentDirectory;
  late final File _taskFile;

  Future<void> init() async {
    _appDocumentDirectory = await getApplicationDocumentsDirectory();

    _taskFile = File("${_appDocumentDirectory.path}/tasky.json");
  }

  Future<void> saveTasks(List<dynamic> list) async {
    final listJson = jsonEncode(list);

    await _taskFile.writeAsString(listJson);
  }

  Future<List<dynamic>> loadTasks() async {
    if (!await _taskFile.exists()) return [];
    final tasksJson = await _taskFile.readAsString();

    return jsonDecode(tasksJson) as List<dynamic>;
  }

  clear() {
    _taskFile.delete();
  }
}
