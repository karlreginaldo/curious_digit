import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/math_trivia.dart';
import '../repositories/math_trivia_repository.dart';

class GetConcreteMathTrivia implements UseCase<MathTrivia, MathTriviaParams> {
  final MathTriviaRepository _repository;

  GetConcreteMathTrivia(this._repository);
  @override
  Future<Either<Failure, MathTrivia>> call(MathTriviaParams params) async {
    return await _repository.getConcreteMathTrivia(params.number);
  }
}

class MathTriviaParams extends Equatable {
  final int number;

  MathTriviaParams(this.number);

  @override
  List<Object> get props => [number];
}
