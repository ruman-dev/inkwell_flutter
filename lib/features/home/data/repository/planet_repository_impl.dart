import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:inkwell/core/utils/failure.dart';
import 'package:inkwell/features/home/data/models/planet_model.dart';
import 'package:inkwell/features/home/domain/repository/planet_repository.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  @override
  Future<Either<PlanetModel, Failure>> fetchPlanetInfo({
    required DateTime date,
  }) async {
    try {
      var apiUrl = "https://api.nasa.gov/planetary/apod";

      final formattedDate = date.toString().split(' ')[0];
      final response = await http.get(
        Uri.parse(
          "$apiUrl?api_key=${dotenv.env['API_KEY']}&date=$formattedDate",
        ),
      );

      if (response.statusCode == 200) {
        return Left(PlanetModel.fromJson(jsonDecode(response.body)));
      } else {
        try {
          final errorData = jsonDecode(response.body);
          return Right(Failure(message: errorData['msg'] ?? "Something went wrong."));
        } catch (_) {
          return Right(Failure(message: "Something went wrong."));
        }
      }
    } catch (e) {
      return Right(Failure(message: "An unexpected error occurred. Please try again."));
    }
  }
}
