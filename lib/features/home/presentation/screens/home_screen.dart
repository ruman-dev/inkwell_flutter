import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                      const Text(
                        'My Notes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -.5,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Obx(
                        () => Text(
                          '${controller.tasks.length} notes available',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      if (!Get.isRegistered<AuthController>()) {
                        Get.put(AuthController()).signOut();
                      } else {
                        Get.find<AuthController>().signOut();
                      }
                    },
                    icon: const Icon(Icons.logout_rounded, color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 28),

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
                        style: TextStyle(color: Colors.grey.shade600),
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
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
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
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color(0xFF17181C),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: .04),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Completion Indicator
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    color: note.isCompleted
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: note.isCompleted
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  child: note.isCompleted
                                      ? const Icon(
                                          Icons.check,
                                          size: 14,
                                          color: Colors.black,
                                        )
                                      : null,
                                ),

                                const SizedBox(width: 16),

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
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          decoration: note.isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      /// Description
                                      Text(
                                        note.description,
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          height: 1.5,
                                          fontSize: 14,
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
        child: const Icon(Icons.add_rounded, color: Colors.black, size: 28),
      ),
    );
  }
}
