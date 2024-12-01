import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todo_list_flutter/controller/task_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TaskController', () {
    late TaskController taskController;

    setUp(()  {
      // Mock SharedPreferences
      SharedPreferences.setMockInitialValues({}); // Initialize with empty data
      taskController = TaskController();
       taskController.onInit(); // Ensure onInit is awaited if it's async
    });

    test('should add a new task', () async {
      taskController.addTask('Test Task');
      expect(taskController.tasks.length, 1);
      expect(taskController.tasks[0].title, 'Test Task');
    });

    test('should mark a task as completed', () async {
      taskController.addTask('Test Task');
      taskController.toggleTaskCompletion(0);
      expect(taskController.tasks[0].isCompleted.value, true); // Use .value
    });

    test('should save tasks to SharedPreferences', () async {
      taskController.addTask('Test Task');
      final prefs = await SharedPreferences.getInstance();
      final taskData = prefs.getString('tasks');
      expect(taskData, isNotNull);

      final decodedData = json.decode(taskData!);
      expect(decodedData.length, 1);
      expect(decodedData[0]['title'], 'Test Task');
      expect(decodedData[0]['isCompleted'], false); // Check default completion state
    });
  });
}
