import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/date_trivia.dart';

class DateTriviaModel extends DateTrivia {
  final String text;
  final int year;
  final int number;
  DateTriviaModel({
    @required this.text,
    @required this.year,
    @required this.number,
  }) : super(text: text, number: number, year: year);

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'year': year,
      'number': number,
    };
  }

  factory DateTriviaModel.fromMap(Map<String, dynamic> map) {
    return DateTriviaModel(
      text: map['text'],
      year: (map['year']).toInt(),
      number: (map['number']).toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DateTriviaModel.fromJson(String source) =>
      DateTriviaModel.fromMap(json.decode(source));
}
