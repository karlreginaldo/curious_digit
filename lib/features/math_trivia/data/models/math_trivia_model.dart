import 'dart:convert';

import 'package:meta/meta.dart';
import '../../domain/entities/math_trivia.dart';

class MathTriviaModel extends MathTrivia {
  final String text;
  final int number;

  MathTriviaModel({
    @required this.text,
    @required this.number,
  }) : super(number: number, text: text);

  @override
  List<Object> get props => [text, number];

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'number': number,
    };
  }

  factory MathTriviaModel.fromMap(Map<String, dynamic> map) {
    return MathTriviaModel(
      text: map['text'],
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MathTriviaModel.fromJson(String source) =>
      MathTriviaModel.fromMap(json.decode(source));
}
