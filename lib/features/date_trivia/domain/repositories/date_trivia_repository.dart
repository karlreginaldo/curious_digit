import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/date_trivia.dart';
import 'package:meta/meta.dart';

abstract class DateTriviaRepository {
  Future<Either<Failure, DateTrivia>> getConcreteDateTrivia(
      {@required int month, @required int day});
  Future<Either<Failure, DateTrivia>> getRandomDateTrivia();
}
