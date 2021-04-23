import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/date_trivia.dart';
import '../repositories/date_trivia_repository.dart';

class GetRandomDateTrivia implements UseCase<DateTrivia, NoParams> {
  final DateTriviaRepository _repository;

  GetRandomDateTrivia(this._repository);

  @override
  Future<Either<Failure, DateTrivia>> call(NoParams params) async {
    return await _repository.getRandomDateTrivia();
  }
}
