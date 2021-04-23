import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia
    implements UseCase<NumberTrivia, NumberTriviaParams> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NumberTriviaParams params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class NumberTriviaParams extends Equatable {
  final int number;

  NumberTriviaParams(this.number);

  @override
  // TODO: implement props
  List<Object> get props => [number];
}
