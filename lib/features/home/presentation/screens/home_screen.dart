import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inkwell/core/routes/app_routes.dart';
import 'package:inkwell/features/auth/presentation/controllers/auth_controller.dart';
import 'package:inkwell/features/home/presentation/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Notes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.spMin,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -.5,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      Obx(
                        () => Text(
                          '${controller.tasks.length} notes available',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15.spMin,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10.w,
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed(AppRoutes.planetInfo),
                        icon: Icon(
                          Icons.public_outlined,
                          color: Colors.white,
                          size: 24.r,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!Get.isRegistered<AuthController>()) {
                            Get.put(AuthController()).signOut();
                          } else {
                            Get.find<AuthController>().signOut();
                          }
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: 24.r,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 28.h),

              /// Notes List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  if (controller.tasks.isEmpty) {
                    return Center(
                      child: Text(
                        'No notes yet. Create one!',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16.spMin,
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: Colors.white,
                    onRefresh: () async {
                      await controller.getTasks();
                    },
                    child: ListView.separated(
                      itemCount: controller.tasks.length,
                      separatorBuilder: (_, _) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final note = controller.tasks[index];

                        return InkWell(
                          onTap: () {
                            if (note.id != null) {
                              controller.toggleTaskStatus(
                                note.id!,
                                note.isCompleted,
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(24.r),
                          child: Container(
                            padding: EdgeInsets.all(18.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFF17181C),
                              borderRadius: BorderRadius.circular(24.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: .04),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Completion Indicator
                                Container(
                                  margin: EdgeInsets.only(top: 4.h),
                                  height: 22.r,
                                  width: 22.r,
                                  decoration: BoxDecoration(
                                    color: note.isCompleted
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: note.isCompleted
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  child: note.isCompleted
                                      ? Icon(
                                          Icons.check,
                                          size: 14.r,
                                          color: Colors.black,
                                        )
                                      : null,
                                ),

                                SizedBox(width: 16.w),

                                /// Note Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Title
                                      Text(
                                        note.title,
                                        style: TextStyle(
                                          color: note.isCompleted
                                              ? Colors.grey.shade500
                                              : Colors.white,
                                          fontSize: 18.spMin,
                                          fontWeight: FontWeight.w600,
                                          decoration: note.isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),

                                      SizedBox(height: 10.h),

                                      /// Description
                                      Text(
                                        note.description,
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          height: 1.5,
                                          fontSize: 14.spMin,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),

      /// Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.addNewTask);
          if (result == true) controller.getTasks();
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.add_rounded, color: Colors.black, size: 28),
      ),
    );
  }
}
