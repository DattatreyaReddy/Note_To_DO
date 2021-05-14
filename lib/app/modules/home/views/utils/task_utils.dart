import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/style.dart';
import '../../../../data/task_model.dart';
import '../../controllers/task_controller.dart';

Future addTask() {
  TaskController taskController = Get.find<TaskController>();
  String? name;
  return Get.defaultDialog(
    title: "Add a New Task",
    textConfirm: "Add",
    content: Container(
      // height: Get.height * .3,
      width: Get.width,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              decoration: kTextFieldDecoration.copyWith(
                labelText: "Add Task Name",
                errorText: taskController.isEmptyName.value
                    ? "Task Name can't be Empty"
                    : null,
              ),
              onChanged: (value) => name = value,
            )
          ],
        ),
      ),
    ),
    onCancel: () {
      Get.back();
      taskController.isEmptyName.value = false;
    },
    onConfirm: () {
      if (name != null && name!.isNotEmpty) {
        taskController.addTask(
          Task(name: name),
        );

        Get.back();
        taskController.isEmptyName.value = false;
      } else {
        taskController.isEmptyName.value = (name == null || name!.isEmpty);
      }
    },
  );
}

Future editTask({required Task task}) {
  TaskController taskController = Get.find<TaskController>();
  String? name = task.name;
  return Get.defaultDialog(
    title: "Edit the Task",
    textConfirm: "Edit",
    content: Container(
      height: Get.height * .3,
      width: Get.width,
      child: Obx(
        () => TextFormField(
          initialValue: task.name,
          decoration: kTextFieldDecoration.copyWith(
            labelText: "Add Task Name",
            errorText:
                taskController.isEmptyName.value ? "Name can't be Empty" : null,
          ),
          onChanged: (value) => name = value,
        ),
      ),
    ),
    onCancel: () {
      Get.back();
      taskController.reloadTasks();
      taskController.isEmptyName.value = false;
    },
    onConfirm: () {
      if (name != null && name!.isNotEmpty) {
        taskController.updateTask(
          Task(
            id: task.id,
            name: name,
            isDone: task.isDone,
          ),
        );

        Get.back();
        taskController.isEmptyName.value = false;
      } else {
        taskController.isEmptyName.value = (name == null || name!.isEmpty);
      }
    },
  );
}
