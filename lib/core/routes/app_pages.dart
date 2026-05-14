import 'package:get/get.dart';
import 'package:inkwell/core/routes/app_routes.dart';
import 'package:inkwell/features/auth/presentation/bindings/auth_bindings.dart';
import 'package:inkwell/features/auth/presentation/screens/auth_screen.dart';
import 'package:inkwell/features/home/presentation/bindings/home_bindings.dart';
import 'package:inkwell/features/home/presentation/screens/add_new_task_screen.dart';
import 'package:inkwell/features/home/presentation/screens/home_screen.dart';
import 'package:inkwell/features/home/presentation/screens/planet_info_screen.dart';

final List<GetPage> pages = [
  GetPage(
    name: AppRoutes.auth,
    page: () => const AuthScreen(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeScreen(),
    binding: HomeBindings(),
  ),
  GetPage(
    name: AppRoutes.addNewTask,
    page: () => const AddNewTaskScreen(),
    binding: HomeBindings(),
  ),
  GetPage(
    name: AppRoutes.planetInfo,
    page: () => const PlanetInfoScreen(),
    binding: HomeBindings(),
  ),
];
