import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/math_trivia.dart';
import '../repositories/math_trivia_repository.dart';

class GetRandomMathTrivia implements UseCase<MathTrivia, NoParams> {
  final MathTriviaRepository _repository;

  GetRandomMathTrivia(this._repository);
  @override
  Future<Either<Failure, MathTrivia>> call(NoParams params) async {
    return await _repository.getRandomMathTrivia();
  }
}
