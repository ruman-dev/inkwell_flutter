import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/core/routes/app_routes.dart';
import 'package:inkwell/features/home/presentation/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
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

                      Text(
                        '${controller.taskData.length} notes available',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B1C20),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// Notes List
              Expanded(
                child: ListView.separated(
                  itemCount: controller.taskData.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final note = controller.taskData[index];

                    return Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF17181C),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .04),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: .start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      /// Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addNewTask),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add_rounded, color: Colors.black, size: 28),
      ),
    );
  }
}
