import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/date_trivia.dart';
import '../repositories/date_trivia_repository.dart';

class GetConcreteDateTrivia implements UseCase<DateTrivia, DateTriviaParams> {
  final DateTriviaRepository _repository;

  GetConcreteDateTrivia(this._repository);

  @override
  Future<Either<Failure, DateTrivia>> call(DateTriviaParams params) async {
    return await _repository.getConcreteDateTrivia(
        day: params.day, month: params.month);
  }
}

class DateTriviaParams extends Equatable {
  final int month;
  final int day;

  DateTriviaParams({@required this.month, @required this.day});

  @override
  List<Object> get props => [month, day];
}
