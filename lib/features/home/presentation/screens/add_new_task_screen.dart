import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/home/presentation/controllers/add_new_task_controller.dart';

class AddNewTaskScreen extends GetView<AddNewTaskController> {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                'Task Title',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .6),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(hintText: 'Enter task title'),
              ),

              const SizedBox(height: 24),

              /// Description
              Text(
                'Description',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .6),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Write task description...',
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 24),

              /// Completion Status
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF17181C),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .04),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .06),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.task_alt_rounded,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mark as Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Enable if this task is already completed.',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Obx(
                      () => Switch(
                        value: controller.isCompleted.value,
                        onChanged: controller.toggleCompletion,
                        activeThumbColor: Colors.black,
                        activeTrackColor: Colors.white,
                        inactiveThumbColor: Colors.grey.shade300,
                        inactiveTrackColor: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// Save Button
              Obx(
                () => ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.createTask(),
                  label: const Text(
                    'Create Task',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  icon: controller.isLoading.value
                      ? const CupertinoActivityIndicator()
                      : const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
