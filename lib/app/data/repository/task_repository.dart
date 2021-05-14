import 'dart:async';

import '../providers/task_provider.dart';
import '../task_model.dart';

class TaskRepository {
  final TaskProvider _taskProvider;

  TaskRepository(this._taskProvider);

  Future<int> insert(Task task) {
    print("${task.isDone} Hi");
    return _taskProvider.insert(task.toJson());
  }

  FutureOr<List<Task>> queryAll() async {
    List<Task> taskList = [];
    List<Map<String, dynamic>> queryList = await _taskProvider.queryAll();
    queryList.forEach((element) => taskList.add(Task.fromJson(element)));
    return taskList;
  }

  Future<int> update(Task task) async {
    return await _taskProvider.update(task.toJson());
  }

  Future<int> delete(Task task) async {
    return await _taskProvider.delete(task.toJson());
  }
}
