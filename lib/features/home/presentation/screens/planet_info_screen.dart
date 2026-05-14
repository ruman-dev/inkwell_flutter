import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/home/presentation/controllers/planet_info_controller.dart';

class PlanetInfoScreen extends GetView<PlanetInfoController> {
  const PlanetInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(children: []),
        ),
      ),
    );
  }
}
