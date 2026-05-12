import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          'New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24.spMin,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                'Task Title',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .6),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.spMin,
                ),
              ),

              SizedBox(height: 12.h),

              TextFormField(
                controller: controller.titleController,
                style: TextStyle(fontSize: 16.spMin),
                decoration: const InputDecoration(hintText: 'Enter task title'),
              ),

              SizedBox(height: 24.h),

              /// Description
              Text(
                'Description',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .6),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.spMin,
                ),
              ),

              SizedBox(height: 12.h),

              TextFormField(
                controller: controller.descriptionController,
                style: TextStyle(fontSize: 16.spMin),
                decoration: const InputDecoration(
                  hintText: 'Write task description...',
                ),
                maxLines: 4,
              ),

              SizedBox(height: 24.h),

              /// Completion Status
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF17181C),
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .04),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 48.r,
                      width: 48.r,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .06),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.task_alt_rounded,
                        color: Colors.white,
                        size: 24.r,
                      ),
                    ),

                    SizedBox(width: 16.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mark as Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.spMin,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          Text(
                            'Enable if this task is already completed.',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 13.spMin,
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

              SizedBox(height: 36.h),

              /// Save Button
              Obx(
                () => ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.createTask(),
                  label: Text(
                    'Create Task',
                    style: TextStyle(
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  icon: controller.isLoading.value
                      ? const CupertinoActivityIndicator()
                      : Icon(Icons.add, size: 20.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
