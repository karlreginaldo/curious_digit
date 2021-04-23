import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/year_trivia.dart';

abstract class YearTriviaRepository {
  Future<Either<Failure, YearTrivia>> getConcreteYearTrivia(int year);
  Future<Either<Failure, YearTrivia>> getRandomYearTrivia();
}
