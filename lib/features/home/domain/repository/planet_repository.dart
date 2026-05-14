import 'package:dartz/dartz.dart';
import 'package:inkwell/core/utils/failure.dart';
import 'package:inkwell/features/home/data/models/planet_model.dart';

abstract interface class PlanetRepository {
  Future<Either<PlanetModel, Failure>> fetchPlanetInfo({
    required DateTime date,
  });
}
