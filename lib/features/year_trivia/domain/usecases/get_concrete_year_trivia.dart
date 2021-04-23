import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/year_trivia.dart';
import '../repositories/year_trivia_repository.dart';

class GetConcreteYearTrivia implements UseCase<YearTrivia, YearTriviaParams> {
  final YearTriviaRepository repository;

  GetConcreteYearTrivia(this.repository);

  @override
  Future<Either<Failure, YearTrivia>> call(YearTriviaParams params) async {
    return await repository.getConcreteYearTrivia(params.year);
  }
}

class YearTriviaParams extends Equatable {
  final int year;

  YearTriviaParams(this.year);

  @override
  List<Object> get props => [year];
}
