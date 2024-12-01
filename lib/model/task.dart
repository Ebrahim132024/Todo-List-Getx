import 'package:get/get.dart';

class Task {
  String title;
  RxBool isCompleted; // Use RxBool for reactivity

  Task({required this.title, bool isCompleted = false})
      : isCompleted = isCompleted.obs;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted.value, // Use value here
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
