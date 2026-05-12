import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  var isCompleted = false.obs;

  void toggleCompletion(bool value) {
    isCompleted.value = value;
  }
}
