part of 'date_trivia_bloc.dart';

abstract class DateTriviaState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends DateTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends DateTriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends DateTriviaState {
  final DateTrivia trivia;

  Loaded({
    @required this.trivia,
  });

  @override
  List<Object> get props => [trivia];
}

class Error extends DateTriviaState {
  final String message;
  Error({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
