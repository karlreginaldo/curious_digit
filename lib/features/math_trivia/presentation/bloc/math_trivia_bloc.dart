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
import '../../domain/entities/math_trivia.dart';
import '../../domain/usecases/get_concrete_math_trivia.dart';
import '../../domain/usecases/get_random_math_trivia.dart';

part 'math_trivia_event.dart';
part 'math_trivia_state.dart';

class MathTriviaBloc extends Bloc<MathTriviaEvent, MathTriviaState> {
  final GetConcreteMathTrivia _concrete;
  final GetRandomMathTrivia _random;
  final InputConverter _input;
  MathTriviaBloc({
    @required GetConcreteMathTrivia concrete,
    @required GetRandomMathTrivia random,
    @required InputConverter input,
  })  : _input = input,
        _concrete = concrete,
        _random = random;

  @override
  MathTriviaState get initialState => Empty();

  @override
  Stream<MathTriviaState> mapEventToState(
    MathTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteMath) {
      final inputEither = _input.stringToInteger(event.str);

      yield* inputEither.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();

        await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));

        final triviaEither = await _concrete(MathTriviaParams(integer));
        yield* _eitherLoadedOrErrorState(triviaEither);
      });
    } else if (event is GetTriviaForRandomMath) {
      yield Loading();

      await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));

      final triviaEither = await _random(NoParams());
      yield* _eitherLoadedOrErrorState(triviaEither);
    }
  }

  Stream<MathTriviaState> _eitherLoadedOrErrorState(
      Either<Failure, MathTrivia> triviaEither) async* {
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
