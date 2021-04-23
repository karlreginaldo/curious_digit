import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final String text;
  final int number;

  NumberTriviaModel({
    @required this.text,
    @required this.number,
  }) : super(number: number, text: text);

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'number': number,
    };
  }

  factory NumberTriviaModel.fromMap(Map<String, dynamic> map) {
    return NumberTriviaModel(
      text: map['text'],
      number: (map['number']).toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NumberTriviaModel.fromJson(String source) =>
      NumberTriviaModel.fromMap(json.decode(source));
}
