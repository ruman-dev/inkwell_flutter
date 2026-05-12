import 'package:get/get.dart';
import 'package:inkwell/features/home/data/models/task_model.dart';

class HomeController extends GetxController {
  final taskData = <TaskModel>[
    TaskModel(
      title: "UI Design Ideas",
      description:
          "Create a soft dark minimal UI for the new notes app project.",
      isCompleted: false,
    ),
    TaskModel(
      title: "Client Meeting",
      description: "Discuss project requirements and API integration details.",
      isCompleted: true,
    ),
    TaskModel(
      title: "Flutter Practice",
      description: "Work on animations and clean architecture structure.",
      isCompleted: false,
    ),
  ];
}
