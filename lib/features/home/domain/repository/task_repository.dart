import 'package:dartz/dartz.dart';
import 'package:inkwell/core/utils/failure.dart';
import 'package:inkwell/features/home/data/models/task_model.dart';

abstract interface class TaskRepository {
  Future<Either<void, Failure>> createTask(
    String title,
    String description,
    bool isCompleted,
  );
  Future<Either<List<TaskModel>, Failure>> getAllTasks();
  Future<Either<void, Failure>> toggleTaskStatus(
    String taskId,
    bool isCompleted,
  );
}
