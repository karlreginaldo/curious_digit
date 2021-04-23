import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddtry4/core/error/exception.dart';
import 'package:tddtry4/features/year_trivia/data/datasources/year_trivia_local_data_source.dart';
import 'package:tddtry4/features/year_trivia/data/models/year_trivia_model.dart';

import '../../../../fixture/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockShared;
  YearTriviaLocalDataSourceImpl local;

  setUp(() {
    mockShared = MockSharedPreferences();
    local = YearTriviaLocalDataSourceImpl(mockShared);
  });

  group('cacheYearTrivia', () {
    final tYearTriviaModel = YearTriviaModel.fromJson(fixture('year.json'));

    test('Should call the setString', () async {
      await local.cacheYearTrivia(tYearTriviaModel);

      verify(
          mockShared.setString('CACHE_YEAR_TRIVIA', tYearTriviaModel.toJson()));
    });
  });

  group('getLastYearTrivia', () {
    final tYearTriviaModel = YearTriviaModel.fromJson(fixture('year.json'));

    test('Should return YearTriviaModel when shared has data', () async {
      when(mockShared.getString(any)).thenReturn(tYearTriviaModel.toJson());

      final actual = await local.getLastYearTrivia();

      expect(actual, tYearTriviaModel);
    });

    test('Should throw CacheException when shared has no data', () async {
      when(mockShared.getString(any)).thenReturn(null);

      final actual = local.getLastYearTrivia;

      expect(() => actual(), throwsA(isA<CacheException>()));
    });
  });
}
