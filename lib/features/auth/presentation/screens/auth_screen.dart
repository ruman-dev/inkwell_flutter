import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/auth/presentation/controllers/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Logo
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .06),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .08),
                    ),
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 28),

                /// Title
                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      controller.isLogin.value
                          ? 'Welcome Back'
                          : 'Create Account',
                      key: ValueKey(controller.isLogin.value),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Obx(
                  () => Text(
                    controller.isLogin.value
                        ? 'Login to continue'
                        : 'Create a new account to continue',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                const SizedBox(height: 36),

                /// Name Field (Only for Register)
                Obx(
                  () => AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: controller.isLogin.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const .only(bottom: 18),
                      child: TextFormField(
                        controller: controller.nameController,
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
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),

                const SizedBox(height: 18),

                /// Password
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordVisibility,
                        icon: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
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
                              child: const Text('Forgot Password?'),
                            ),
                          )
                        : const SizedBox(height: 14),
                  ),
                ),

                const SizedBox(height: 20),

                /// Button
                ElevatedButton(
                  onPressed: controller.submit,
                  child: Obx(
                    () => Text(
                      controller.isLogin.value ? 'Login' : 'Create Account',
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                /// Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 28),

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
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 14),
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
    );
  }
}
