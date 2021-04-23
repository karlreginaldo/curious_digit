import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MathTrivia extends Equatable {
  final String text;
  final int number;
  MathTrivia({
    @required this.text,
    @required this.number,
  });

  @override
  List<Object> get props => [text, number];
}
