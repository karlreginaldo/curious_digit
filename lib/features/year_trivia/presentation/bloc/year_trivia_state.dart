part of 'year_trivia_bloc.dart';

abstract class YearTriviaState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends YearTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends YearTriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends YearTriviaState {
  final YearTrivia trivia;

  Loaded({
    @required this.trivia,
  });

  @override
  List<Object> get props => [trivia];
}

class Error extends YearTriviaState {
  final String message;
  Error({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
