import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/date_trivia.dart';
import '../../domain/usecases/get_concrete_date_trivia.dart';
import '../../domain/usecases/get_random_date_trivia.dart';
part 'date_trivia_event.dart';
part 'date_trivia_state.dart';

class DateTriviaBloc extends Bloc<DateTriviaEvent, DateTriviaState> {
  final GetConcreteDateTrivia _concrete;
  final GetRandomDateTrivia _random;
  final InputConverter _input;

  DateTriviaBloc(
      {@required GetConcreteDateTrivia concrete,
      @required GetRandomDateTrivia random,
      @required InputConverter input})
      : _concrete = concrete,
        _random = random,
        _input = input;
  @override
  Stream<DateTriviaState> mapEventToState(
    DateTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteDate) {
      final day = int.parse(event.strDay);
      final month = _input.stringMonthToInteger(event.strMonth);

      yield Loading();

      await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));

      final triviaEither =
          await _concrete(DateTriviaParams(day: day, month: month));

      yield* _eitherLoadedOrErrorState(triviaEither);
    } else if (event is GetTriviaForRandomDate) {
      yield Loading();

      await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));

      final triviaEither = await _random(NoParams());

      yield* _eitherLoadedOrErrorState(triviaEither);
    }
  }

  Stream<DateTriviaState> _eitherLoadedOrErrorState(
      Either<Failure, DateTrivia> triviaEither) async* {
    yield triviaEither.fold(
      (failure) => Error(message: _errorMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _errorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure is CacheFailure) {
      return CACHE_FAILURE_MESSAGE;
    } else {
      return 'Unexpected Error';
    }
  }

  @override
  DateTriviaState get initialState => Empty();
}
