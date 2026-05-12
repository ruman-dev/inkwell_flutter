import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/home/data/repository/task_repository_impl.dart';

class AddNewTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final repository = TaskRepositoryImpl();

  var isCompleted = false.obs;
  var isLoading = false.obs;

  void toggleCompletion(bool value) {
    isCompleted.value = value;
  }

  Future<void> createTask() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Title cannot be empty');
      return;
    }

    isLoading.value = true;
    final result = await repository.createTask(
      titleController.text.trim(),
      descriptionController.text.trim(),
      isCompleted.value,
    );
    isLoading.value = false;

    result.fold(
      (success) {
        Get.back(result: true);
      },
      (failure) {
        Get.snackbar('Error', failure.message);
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
