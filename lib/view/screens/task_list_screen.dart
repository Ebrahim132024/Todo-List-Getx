import 'package:flutter/material.dart';
import 'package:todo_list_flutter/controller/task_controller.dart';
import 'package:get/get.dart';

class TodoListScreen extends StatelessWidget {

  final TaskController controller = Get.put(TaskController());
  final TextEditingController textController = TextEditingController();

   TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("To-Do List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Enter task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.addTask(textController.text);
                      textController.clear();
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    leading: Obx(() => Checkbox(
                      value: task.isCompleted.value, // Use RxBool's value
                      onChanged: (_) {
                        controller.toggleTaskCompletion(index);
                      },
                    )),
                    trailing: Obx(() =>task.isCompleted.value == true? Icon(Icons.check_circle_outline, color: Colors.green,):SizedBox() ),
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}