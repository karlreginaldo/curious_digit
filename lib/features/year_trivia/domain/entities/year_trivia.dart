import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class YearTrivia extends Equatable {
  final String text;
  final int year;

  YearTrivia({@required this.text, @required this.year});

  @override
  // TODO: implement props
  List<Object> get props => [text, year];
}
