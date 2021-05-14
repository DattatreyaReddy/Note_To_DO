import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'note_view.dart';
import 'task_view.dart';
import 'utils/note_utils.dart';
import 'utils/task_utils.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Note To Do'),
          centerTitle: true,
          toolbarHeight: Get.height * .1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.find<HomeController>().currentIndex.value == 1
              ? addNote()
              : addTask(),
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: Get.find<HomeController>().currentIndex.value,
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                      icon: Icon(Icons.check_rounded),
                      onPressed: () => Get.find<HomeController>().toToDO()),
                  label: "To Do",
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Get.find<HomeController>().toNote(),
                  ),
                  label: "Note",
                ),
              ],
            )),
        body: PageView(
          controller: Get.find<HomeController>().pageController,
          onPageChanged: (value) =>
              Get.find<HomeController>().currentIndex.value = value,
          children: [
            TaskView(),
            NoteView(),
          ],
        ),
      ),
    );
  }
}
