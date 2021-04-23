part of 'year_trivia_bloc.dart';

abstract class YearTriviaEvent extends Equatable {
  const YearTriviaEvent();
}

class GetTriviaForConcreteYear extends YearTriviaEvent {
  final String str;

  GetTriviaForConcreteYear(this.str);

  @override
  List<Object> get props => [str];
}

class GetTriviaForRandomYear extends YearTriviaEvent {
  @override
  List<Object> get props => [];
}
