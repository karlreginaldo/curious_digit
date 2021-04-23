import 'package:flutter_test/flutter_test.dart';
import 'package:tddtry4/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tddtry4/features/year_trivia/data/models/year_trivia_model.dart';
import 'package:tddtry4/features/year_trivia/domain/entities/year_trivia.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tYearTriviaModel = YearTriviaModel(year: 1, text: 'Test');
  group('YearTriviaModel', () {
    test('Should return ✅ if the YearTriviaModel is a subclass of YearTrivia',
        () async {
      expect(tYearTriviaModel, isA<YearTrivia>());
    });
  });

  group('fromJson', () {
    final tYearTriviaModel = NumberTriviaModel(number: 1, text: 'Test');

    test('Should return YearNumberTriviaModel if the year in api is integer',
        () async {
      final actual = NumberTriviaModel.fromJson(fixture('year.json'));
      expect(actual, tYearTriviaModel);
    });

    test('Should return YearNumberTriviaModel if the year in api is double',
        () async {
      final actual = NumberTriviaModel.fromJson(fixture('year_double.json'));
      expect(actual, tYearTriviaModel);
    });
  });

  group('toJson', () {
    test('Should return string json if NumberTriviaModel.toJson is called',
        () async {
      final matcher = tYearTriviaModel.toJson();
      final actual = '{"text":"Test","number":1}';
      expect(actual, matcher);
    });
  });
}
