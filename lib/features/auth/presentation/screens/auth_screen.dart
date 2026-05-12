import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inkwell/core/utils/validations.dart';
import 'package:inkwell/features/auth/presentation/controllers/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo
                  Container(
                    height: 60.r,
                    width: 60.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .06),
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .08),
                      ),
                    ),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                      size: 28.r,
                    ),
                  ),

                  SizedBox(height: 28.h),

                  /// Title
                  Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        controller.isLogin.value
                            ? 'Welcome Back'
                            : 'Create Account',
                        key: ValueKey(controller.isLogin.value),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.spMin,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -.5,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Obx(
                    () => Text(
                      controller.isLogin.value
                          ? 'Login to continue'
                          : 'Create a new account to continue',
                      style: TextStyle(
                        color: const Color(0xFF9E9E9E),
                        fontSize: 15.spMin,
                      ),
                    ),
                  ),

                  SizedBox(height: 36.h),

                  /// Name Field (Only for Register)
                  Obx(
                    () => AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: controller.isLogin.value
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: EdgeInsets.only(bottom: 18.h),
                        child: TextFormField(
                          controller: controller.nameController,
                          validator: (value) {
                            if (controller.isLogin.value) return null;
                            return Validation.validateField(value);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Email
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validation.validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  /// Password
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.isPasswordHidden.value,
                      validator: Validation.validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: Colors.grey.shade400,
                            size: 20.r,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Forgot Password
                  Obx(
                    () => AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: controller.isLogin.value ? 1.0 : 0.0,
                      child: controller.isLogin.value
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.snackbar(
                                    'Coming soon',
                                    'This feature is not yet implemented.',
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey.shade400,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(fontSize: 14.spMin),
                                ),
                              ),
                            )
                          : SizedBox(height: 14.h),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// Button
                  Obx(
                    () => ElevatedButton.icon(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.onSubmit();
                              }
                            },
                      label: Text(
                        controller.isLogin.value ? 'Login' : 'Create Account',
                        style: TextStyle(fontSize: 16.spMin),
                      ),
                      icon: controller.isLoading.value
                          ? const CupertinoActivityIndicator()
                          : const SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(height: 28.h),

                  /// Divider
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12.spMin,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 28.h),

                  /// Toggle Auth Mode
                  Center(
                    child: GestureDetector(
                      onTap: controller.toggleAuthMode,
                      child: Obx(
                        () => RichText(
                          text: TextSpan(
                            text: controller.isLogin.value
                                ? "Don't have an account? "
                                : "Already have an account? ",
                            style: TextStyle(
                              color: const Color(0xFF9E9E9E),
                              fontSize: 14.spMin,
                            ),
                            children: [
                              TextSpan(
                                text: controller.isLogin.value
                                    ? 'Register'
                                    : 'Login',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
