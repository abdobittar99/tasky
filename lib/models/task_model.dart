class TaskModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool ishighPriority;
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
