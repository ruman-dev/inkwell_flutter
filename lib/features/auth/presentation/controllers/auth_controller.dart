import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/core/routes/app_routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final isLogin = true.obs;

  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
    update();
  }

  final isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
    update();
  }

  void submit() {
    Get.offAndToNamed(AppRoutes.home);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
