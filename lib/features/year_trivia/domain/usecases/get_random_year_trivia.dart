import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/year_trivia.dart';
import '../repositories/year_trivia_repository.dart';

class GetRandomYearTrivia implements UseCase<YearTrivia, NoParams> {
  final YearTriviaRepository repository;

  GetRandomYearTrivia(this.repository);

  @override
  Future<Either<Failure, YearTrivia>> call(NoParams params) async {
    return await repository.getRandomYearTrivia();
  }
}
