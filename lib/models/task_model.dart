import 'package:hive_ce_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String taskName;
  @HiveField(2)
  final String taskDescription;
  @HiveField(3)
  final bool ishighPriority;
  @HiveField(4)
  bool isDone;
  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.ishighPriority,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      taskName: json['taskName'],
      taskDescription: json["taskDescription"],
      ishighPriority: json["isHigh"],
      isDone: json["isDone"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHigh": ishighPriority,
      "isDone": isDone,
    };
  }
}
