part of 'math_trivia_bloc.dart';

abstract class MathTriviaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteMath extends MathTriviaEvent {
  final String str;

  GetTriviaForConcreteMath(this.str);

  @override
  List<Object> get props => [str];
}

class GetTriviaForRandomMath extends MathTriviaEvent {
  @override
  List<Object> get props => [];
}
