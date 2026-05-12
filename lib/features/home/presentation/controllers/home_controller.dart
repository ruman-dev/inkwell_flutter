import 'package:get/get.dart';
import 'package:inkwell/features/home/data/models/task_model.dart';
import 'package:inkwell/features/home/data/repository/task_repository_impl.dart';

class HomeController extends GetxController {
  final repository = TaskRepositoryImpl();
  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTasks();
  }

  Future<void> getTasks() async {
    isLoading.value = true;
    final result = await repository.getAllTasks();
    isLoading.value = false;

    result.fold(
      (data) {
        tasks.assignAll(data);
      },
      (failure) {
        Get.snackbar('Error', failure.message);
      },
    );
  }

  Future<void> toggleTaskStatus(String taskId, bool currentStatus) async {
    final index = tasks.indexWhere((task) => task.id == taskId);
    if (index == -1) return;

    final originalStatus = tasks[index].isCompleted;
    tasks[index].isCompleted = !currentStatus;
    tasks.refresh();

    final result = await repository.toggleTaskStatus(taskId, !currentStatus);

    result.fold((success) => null, (failure) {
      tasks[index].isCompleted = originalStatus;
      tasks.refresh();
      Get.snackbar('Error', failure.message);
    });
  }
}
