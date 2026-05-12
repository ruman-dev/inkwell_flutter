import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inkwell/core/utils/failure.dart';
import 'package:inkwell/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<User, Failure>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      print("Sign In: $email + $password");
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Left(user.user!);
    } on FirebaseAuthException catch (e) {
      return Right(Failure(message: e.message ?? "Authentication failed"));
    } catch (e) {
      print("Sign In Error: $e");
      return Right(Failure(message: "Something went wrong. Please try again."));
    }
  }

  @override
  Future<Either<User, Failure>> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      print("Sign Up: $email + $password");
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user!.displayName == null) {
        await user.user!.updateDisplayName(name);
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({
            "uid": user.user!.uid,
            "name": name,
            "email": email,
            "photoUrl": user.user!.photoURL,
            "createdAt": FieldValue.serverTimestamp(),
          });
      await user.user!.reload();

      return Left(user.user!);
    } on FirebaseAuthException catch (e) {
      return Right(Failure(message: e.message ?? "Account creation failed"));
    } catch (e) {
      print("Sign Up Error: $e");
      return Right(Failure(message: "Something went wrong. Please try again."));
    }
  }
}
