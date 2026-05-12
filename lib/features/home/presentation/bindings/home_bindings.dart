import 'package:get/instance_manager.dart';
import 'package:inkwell/features/home/presentation/controllers/add_new_task_controller.dart';
import 'package:inkwell/features/home/presentation/controllers/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddNewTaskController>(() => AddNewTaskController());
  }
}
