import 'package:get/get.dart';
import 'package:inkwell/features/auth/presentation/bindings/auth_bindings.dart';
import 'package:inkwell/features/auth/presentation/screens/auth_screen.dart';

final List<GetPage> pages = [
  GetPage(
    name: '/auth',
    page: () => const AuthScreen(),
    binding: AuthBindings(),
  ),
];
