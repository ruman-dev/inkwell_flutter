import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/core/routes/app_routes.dart';
import 'package:inkwell/features/auth/data/repository/auth_repository_impl.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  var isLoading = false.obs;
  final isLogin = true.obs;
  final isPasswordHidden = true.obs;
  final formKey = GlobalKey<FormState>();

  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
    formKey.currentState?.reset();
    update();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
    update();
  }

  void onSubmit() {
    isLogin.value ? _signIn() : _signUp();
  }

  Future<void> _signIn() async {
    isLoading.value = true;
    dev.log("Signing In...", name: 'Auth Screen');
    final result = await AuthRepositoryImpl().signInWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;
    result.fold(
      (data) {
        Get.offAndToNamed(AppRoutes.home);
      },
      (failure) {
        Get.snackbar('Error', failure.message);
      },
    );
  }

  Future<void> _signUp() async {
    isLoading.value = true;
    final result = await AuthRepositoryImpl().signUpWithEmailAndPassword(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;
    result.fold(
      (data) {
        Get.offAndToNamed(AppRoutes.home);
      },
      (failure) {
        Get.snackbar('Error', failure.message);
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
