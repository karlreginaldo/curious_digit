import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/year_trivia.dart';
import '../../domain/usecases/get_concrete_year_trivia.dart';
import '../../domain/usecases/get_random_year_trivia.dart';
import 'dart:math';
part 'year_trivia_event.dart';

part 'year_trivia_state.dart';

class YearTriviaBloc extends Bloc<YearTriviaEvent, YearTriviaState> {
  final GetConcreteYearTrivia _concrete;
  final GetRandomYearTrivia _random;
  final InputConverter _input;

  YearTriviaBloc(
      {@required GetConcreteYearTrivia concrete,
      @required GetRandomYearTrivia random,
      @required InputConverter input})
      : _concrete = concrete,
        _random = random,
        _input = input;

  @override
  YearTriviaState get initialState => Empty();

  @override
  Stream<YearTriviaState> mapEventToState(
    YearTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteYear) {
      final _inputEither = _input.stringToInteger(event.str);

      yield* _inputEither.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();
        await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));
        final _triviaEither = await _concrete(YearTriviaParams(integer));

        yield* _eitherLoadedOrErrorState(_triviaEither);
      });
    } else if (event is GetTriviaForRandomYear) {
      yield Loading();

      await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));
      final _triviaEither = await _random(NoParams());

      yield* _eitherLoadedOrErrorState(_triviaEither);
    }
  }

  Stream<YearTriviaState> _eitherLoadedOrErrorState(
      Either<Failure, YearTrivia> _triviaEither) async* {
    yield* _triviaEither.fold((failure) async* {
      yield Error(message: _errorMessage(failure));
    }, (trivia) async* {
      yield Loaded(trivia: trivia);
    });
  }

  String _errorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure is Failure) {
      return CACHE_FAILURE_MESSAGE;
    } else {
      return 'Unexpected Error';
    }
  }
}
