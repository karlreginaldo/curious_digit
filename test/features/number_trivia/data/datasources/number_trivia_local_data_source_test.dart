import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddtry4/core/error/exception.dart';
import 'package:tddtry4/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tddtry4/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixture/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockShared;
  NumberTriviaLocalDataSourceImpl local;
  setUp(() {
    mockShared = MockSharedPreferences();
    local = NumberTriviaLocalDataSourceImpl(mockShared);
  });
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test');

  group('getLastNumberTrivia', () {
    test('Should return NumberTriviaModel when sharedPreferences return String',
        () async {
      when(mockShared.getString('CACHED_NUMBER_TRIVIA'))
          .thenReturn(fixture('trivia.json'));

      final actual = await local.getLastNumberTrivia();

      expect(actual, tNumberTriviaModel);
      verify(mockShared.getString('CACHED_NUMBER_TRIVIA'));
    });
    test('Should return NumberTriviaModel when sharedPreferences return String',
        () async {
      when(mockShared.getString('CACHED_NUMBER_TRIVIA')).thenReturn(null);

      final actual = local.getLastNumberTrivia;

      expect(() => actual(), throwsA(isA<CacheException>()));
      verify(mockShared.getString('CACHED_NUMBER_TRIVIA'));
    });
  });

  group('cacheNumberTrivia', () {
    test('Verify if setString was called', () async {
      await local.cacheNumberTrivia(tNumberTriviaModel);

      verify(mockShared.setString(
          'CACHED_NUMBER_TRIVIA', tNumberTriviaModel.toJson()));
    });
  });
}
