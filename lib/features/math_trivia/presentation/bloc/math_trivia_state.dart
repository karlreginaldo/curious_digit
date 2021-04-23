part of 'math_trivia_bloc.dart';

abstract class MathTriviaState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MathTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends MathTriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends MathTriviaState {
  final MathTrivia trivia;

  Loaded({
    @required this.trivia,
  });

  @override
  List<Object> get props => [trivia];
}

class Error extends MathTriviaState {
  final String message;
  Error({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
