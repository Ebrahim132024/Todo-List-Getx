import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:todo_list_flutter/model/task.dart';


class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskData = prefs.getString('tasks');
    if (taskData != null) {
      final List<dynamic> decodedData = json.decode(taskData);
      tasks.value = decodedData.map((e) => Task.fromMap(e)).toList();
    }
  }

  void addTask(String title) {
    final newTask = Task(title: title);
    tasks.add(newTask);
    _saveTasks();
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted.toggle(); // Toggle the RxBool value
    tasks.refresh(); // Ensure the UI updates
    _saveTasks();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskData = json.encode(tasks.map((task) => task.toMap()).toList());
    await prefs.setString('tasks', taskData);
  }
}
