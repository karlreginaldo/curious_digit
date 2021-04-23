import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DateTrivia extends Equatable {
  final String text;
  final int year;
  final int number;

  DateTrivia({@required this.text, @required this.year, @required this.number});

  @override
  // TODO: implement props
  List<Object> get props => [text, year, number];
}
