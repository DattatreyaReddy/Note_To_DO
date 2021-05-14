import 'dart:async';

import 'package:get/get.dart';

import '../../../data/providers/task_provider.dart';
import '../../../data/repository/task_repository.dart';
import '../../../data/task_model.dart';

class TaskController extends GetxController {

  TaskRepository _taskRepository = TaskRepository(TaskProvider.instance);

  RxBool isEmptyName = false.obs;

  RxList<Task> tasks = <Task>[].obs;

  Future<void> reloadTasks() async {
    tasks.clear();
    tasks.addAll(await _taskRepository.queryAll());
  }

  Future<void> removeTask(Task task) async {
    tasks.remove(task);
    _taskRepository.delete(task);
  }

  Future<void> addTask(Task task) async {
    print(task.isDone);
    task.id = await _taskRepository.insert(task);
    reloadTasks();
  }

  FutureOr<int> updateTask(Task task) async {
    await _taskRepository.update(task);
    reloadTasks();
    return task.id!;
  }

  final count = 0.obs;
  @override
  void onInit() {
    reloadTasks();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
