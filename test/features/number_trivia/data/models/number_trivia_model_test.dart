import 'package:flutter_test/flutter_test.dart';
import 'package:tddtry4/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tddtry4/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test');
  test('Check if the NumberTriviaModel is a subclass of NumberTrivia',
      () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group('fromJson', () {
    test('should return ✅ if the API gives integer', () async {
      final actual = NumberTriviaModel.fromJson(fixture('trivia.json'));

      expect(actual, tNumberTriviaModel);
    });

    test('should return ✅ even the API gives double', () async {
      final actual = NumberTriviaModel.fromJson(fixture('trivia_double.json'));

      expect(actual, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return ✅ if the json string is legit as fuck', () async {
      final actual = '{"text":"Test","number":1}';
      final matcher = tNumberTriviaModel.toJson();

      expect(actual, matcher);
    });
  });
}
