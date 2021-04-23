import 'dart:convert';

import '../../domain/entities/year_trivia.dart';
import 'package:meta/meta.dart';

class YearTriviaModel extends YearTrivia {
  final String text;
  final int year;
  YearTriviaModel({
    @required this.text,
    @required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'number': year,
    };
  }

  factory YearTriviaModel.fromMap(Map<String, dynamic> map) {
    return YearTriviaModel(
      text: map['text'],
      year: (map['number']).toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory YearTriviaModel.fromJson(String source) =>
      YearTriviaModel.fromMap(json.decode(source));
}
