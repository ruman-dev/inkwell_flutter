import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/home/presentation/controllers/planet_info_controller.dart';
import 'package:intl/intl.dart';

class PlanetInfoScreen extends GetView<PlanetInfoController> {
  const PlanetInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 20.w, vertical: 16.h),
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
                      Text(
                        'Planet Info',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.spMin,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -.5,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Astronomy Picture of the Day',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15.spMin,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 26.r,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              /// Date Picker Row
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate.value,
                            firstDate: DateTime(1995, 6, 16),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    surface: Color(0xFF17181C),
                                    onSurface: Colors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            controller.selectDate(picked);
                          }
                        },
                        borderRadius: BorderRadius.circular(18.r),
                        child: Container(
                          padding: .symmetric(horizontal: 18.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF17181C),
                            borderRadius: .circular(18.r),
                            border: .all(
                              color: Colors.white.withValues(alpha: .05),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                                size: 22.r,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                DateFormat(
                                  'yyyy-MM-dd',
                                ).format(controller.selectedDate.value),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.spMin,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () => controller.fetchPlanetInfo(),
                      child: Container(
                        height: 56.h,
                        width: 56.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: 24.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 22.h),

              /// Navigation Buttons
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.previousDay(),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        label: const Text("Previous"),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: controller.isToday
                            ? null
                            : () => controller.nextDay(),
                        iconAlignment: .end,
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        label: const Text("Next"),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              /// Content Area
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  if (controller.errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.spMin,
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        /// Media Section
                        Container(
                          height: 260.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF17181C),
                            borderRadius: BorderRadius.circular(28.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: .04),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: controller.mediaType.value == "image"
                              ? CachedNetworkImage(
                                  imageUrl: controller.mediaUrl.value,
                                  fit: BoxFit.cover,
                                  memCacheWidth: 250.w.toInt(),
                                  memCacheHeight: 250.h.toInt(),
                                  errorWidget: (_, _, _) => Center(
                                    child: Icon(
                                      Icons.broken_image_rounded,
                                      color: Colors.grey,
                                      size: 50.r,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.play_circle_fill_rounded,
                                    color: Colors.white,
                                    size: 70.r,
                                  ),
                                ),
                        ),

                        SizedBox(height: 22.h),

                        /// Title
                        Text(
                          controller.title.value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.spMin,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        /// Date
                        Text(
                          controller.dateStr.value,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14.spMin,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// Explanation
                        Text(
                          controller.explanation.value,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            height: 1.7,
                            fontSize: 15.spMin,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
