import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inkwell/core/utils/failure.dart';

abstract class AuthRepository {
  Future<Either<User, Failure>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<User, Failure>> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  );
  Future<void> signOut();
}
