part of 'date_trivia_bloc.dart';

abstract class DateTriviaEvent extends Equatable {
  const DateTriviaEvent();
}

class GetTriviaForConcreteDate extends DateTriviaEvent {
  final String strMonth;
  final String strDay;
  GetTriviaForConcreteDate({
    @required this.strMonth,
    @required this.strDay,
  });

  @override
  List<Object> get props => [];
}

class GetTriviaForRandomDate extends DateTriviaEvent {
  @override
  List<Object> get props => [];
}
