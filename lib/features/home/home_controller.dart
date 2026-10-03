import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/models/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];

  String? username;
  String? userImageProf;
  String? motivattionQuote;

  List<TaskModel> tasks = [];
  bool isloading = false;

  init() {
    loadUser();
  }

  void loadUser() async {
    username = PreferencesManeger().getString(StorageKey.username);
    userImageProf = PreferencesManeger().getString(StorageKey.userImage);
    motivattionQuote =
        PreferencesManeger().getString(StorageKey.motivattionQuote) ??
        "One task at a time.One step closer.";

    notifyListeners();
  }
}
