import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _concrete;
  final GetRandomNumberTrivia _random;
  final InputConverter _input;
  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required InputConverter input,
  })  : _input = input,
        _concrete = concrete,
        _random = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither = _input.stringToInteger(event.str);

      yield* inputEither.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();

        await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));

        final triviaEither = await _concrete(NumberTriviaParams(integer));
        yield* _eitherLoadedOrErrorState(triviaEither);
      });
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();

      await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));

      final triviaEither = await _random(NoParams());
      yield* _eitherLoadedOrErrorState(triviaEither);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
      Either<Failure, NumberTrivia> triviaEither) async* {
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
}
