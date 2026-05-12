import 'package:dartz/dartz.dart';
import 'package:inkwell/core/utils/failure.dart';
import 'package:inkwell/features/home/data/models/task_model.dart';
import 'package:inkwell/features/home/domain/repository/task_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskRepositoryImpl implements TaskRepository {
  final firestore = FirebaseFirestore.instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get taskRef =>
      firestore.collection('users').doc(uid).collection('tasks');

  @override
  Future<Either<void, Failure>> createTask(
    String title,
    String description,
    bool isCompleted,
  ) async {
    try {
      await taskRef.add({
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });

      return const Left(null);
    } on FirebaseException catch (e) {
      return Right(Failure(message: e.message ?? "Failed to create task."));
    } catch (e) {
      return Right(Failure(message: "Something went wrong."));
    }
  }

  @override
  Future<Either<List<TaskModel>, Failure>> getAllTasks() async {
    try {
      final snapshot = await taskRef
          .orderBy("createdAt", descending: true)
          .get();

      final tasks = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return TaskModel.fromJson(data, doc.id);
      }).toList();

      return Left(tasks);
    } on FirebaseException catch (e) {
      return Right(Failure(message: e.message ?? "Failed to fetch tasks."));
    } catch (e) {
      return Right(Failure(message: "Something went wrong."));
    }
  }

  @override
  Future<Either<void, Failure>> toggleTaskStatus(
    String taskId,
    bool isCompleted,
  ) async {
    try {
      await taskRef.doc(taskId).update({
        "isCompleted": isCompleted,
        "updatedAt": FieldValue.serverTimestamp(),
      });

      return const Left(null);
    } on FirebaseException catch (e) {
      return Right(Failure(message: e.message ?? "Failed to update task."));
    } catch (e) {
      return Right(Failure(message: "Something went wrong."));
    }
  }
}
