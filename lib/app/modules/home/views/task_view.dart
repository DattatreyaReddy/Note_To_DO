import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/task_model.dart';
import '../controllers/task_controller.dart';
import 'utils/task_utils.dart';

class TaskView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetX<TaskController>(
      init: TaskController(),
      builder: (_) {
        return _.tasks.isEmpty
            ? Center(child: Text('Click " + " buttton to add New Task '))
            : RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(milliseconds: 500), () {
                    _.reloadTasks();
                  });
                },
                child: ListView.builder(
                  itemCount: _.tasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (direction) {
                        direction == DismissDirection.endToStart
                            ? _.removeTask(_.tasks[index])
                            : editTask(task: _.tasks[index]);
                      },
                      direction: DismissDirection.horizontal,
                      background: Container(
                        color: Colors.green,
                        child: Align(
                          alignment: Alignment(-0.9, 0),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment(0.9, 0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      key: UniqueKey(),
                      child: Obx(() => Card(
                            color: _.tasks[index].isDone == 1
                                ? Get.theme.canvasColor
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: CheckboxListTile(
                              value: _.tasks[index].isDone == 1 ? true : false,
                              onChanged: (value) {
                                _.updateTask(Task(
                                  id: _.tasks[index].id,
                                  name: _.tasks[index].name,
                                  isDone: value! ? 1 : 0,
                                ));
                              },
                              title: Text(
                                _.tasks[index].name!,
                                style: TextStyle(
                                  decoration: _.tasks[index].isDone == 1
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                ),
              );
      },
    );
  }
}
