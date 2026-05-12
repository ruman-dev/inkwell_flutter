import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/home/presentation/controllers/add_new_task_controller.dart';

class AddNewTaskScreen extends GetView<AddNewTaskController> {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Task")),
      body: SafeArea(child: Center(child: Text("Add New Task"))),
    );
  }
}
