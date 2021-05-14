import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/note_controller.dart';
import '../controllers/task_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(
      () => TaskController(),
    );
    Get.lazyPut<NoteController>(
      () => NoteController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
