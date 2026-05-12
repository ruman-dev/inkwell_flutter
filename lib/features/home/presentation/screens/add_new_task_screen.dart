import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/home/presentation/controllers/home_controller.dart';

class AddNewTaskScreen extends GetView<HomeController> {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: const Center(child: Text("Add New Task")),
    );
  }
}
